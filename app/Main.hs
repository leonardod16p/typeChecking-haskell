module Main where

import Text.Megaparsec (parse, errorBundlePretty, eof)
import qualified Data.Map as M
import Language.Types 
import Language.Parser
import Language.TypeCheck  


-- Função auxiliar para rodar os testes

run :: String -> IO ()
run input = do
    putStrLn $ "Entrada: " ++ input
    case parse (parseExpr <* eof) "" input of
        Left err -> putStrLn $ "Erro de Sintaxe:\n" ++ errorBundlePretty err
        Right expr -> do
            putStrLn $ "Árvore Sintatica: " ++ show expr
            -- M.empty cria um contexto vazio inicial
            case inferType M.empty expr of
                Just ty -> putStrLn $ "Deu bom. Tipo Inferido: " ++ show ty
                Nothing -> putStrLn "Erro de Tipo: Não foi possível tipar a expressão."
    putStrLn "---------------------------------------------------"

main :: IO ()
main = do
    putStrLn "Tetes Type Checker Bidirecional"
    
    -- Teste 1: Bool simples
    run "True"
    
    -- Teste 2: If
    run "If True Then False Else True"
    
    -- Teste 3: Lambda Identidade
    run "(\\x. x) : Bool -> Bool"

    -- Teste 4: Aplicacao
    run "((\\x. x) : Bool -> Bool) True"

    -- Teste 5: Complexo
    run "(\\x. \\y. x) : Bool -> Bool -> Bool"
    
    -- Teste 6: Erro de Tipo
    run "If True Then True Else (\\x. x)"

    -- Teste 7: abstracao com 3 parametros
    run "(\\x. \\y. \\z. x) : Bool -> Bool -> Bool -> Bool"