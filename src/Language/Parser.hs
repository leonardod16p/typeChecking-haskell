module Language.Parser (parseExpr) where

import Text.Megaparsec
import Text.Megaparsec.Char
import Data.Void
import Language.Types  -- Importando o arquivo com os nossos tipos


type Parser = Parsec Void String 

-- Parsing expression


{-

Vamos primeiro parsear expressoes atomicas

-}

parseAtom :: Parser Expr
parseAtom = parseLitBool <|> parseParenExpr <|> parseVar

-- lista de palavras que não podem ser variaveis
reservedWords :: [String]
reservedWords = ["If", "Then", "Else", "True", "False"]

-- A ideia eh q a gente pegue uma e somente uma letra minuscula do alfabeto 
parseVar :: Parser Expr  -- Expr Var   
parseVar = do
    name <- some lowerChar 
    space
    return (Var name) 

parseLitBool :: Parser Expr -- Expr LitBool
parseLitBool = do
    value <- string "True" <|> string "False" 
    space
    if value == "True" then return (LitBool True) else return (LitBool False)   



parseParenExpr :: Parser Expr
parseParenExpr = do
    _ <- char '('
    x <- parseExpr
    _ <- char ')'
    space
    return x 

parseApp :: Parser Expr -- Expr App
parseApp = do 
    atoms <- some parseAtom 
    return (foldl1 App atoms)

parseTerm :: Parser Expr
parseTerm = parseLambda <|> parseIf <|> parseApp

parseLambda :: Parser Expr  -- Expr Lambda 
parseLambda = do 
    _ <- char '\\' -- ele n aceita \ como caracter. usei o l para representar o '\'
    var <- letterChar 
    space -- eu preciso exigir um espaco. essa funcao simplesmente ignora zero ou mais espacos
    _ <- char '.' 
    space
    body <- parseExpr 
    space -- eu preciso exigir um espaco. essa funcao simplesmente ignora zero ou mais espacos
    return (Lambda [var] body) 

parseIf :: Parser Expr -- expr expr expr 
parseIf = do
    _ <- string "If"
    space
    expr1 <- parseExpr 
    space 
    _ <- string "Then"
    space
    expr2 <- parseExpr 
    space  
    _ <- string "Else"
    space
    expr3 <- parseExpr
    space
    return (If expr1 expr2 expr3)

-- Parsing Types 


parseType :: Parser Type
parseType = do
    t1 <- parseAtomType
    space 
    -- aqui a gente verifica se tem flecha, se tiver a gente faz recursao de cauda em cima da flecha. Se n tiver a gente retorna t1
    (do 
        _ <- string "->"
        space
        t2 <- parseType 
        return (TArrow t1 t2)            
     ) <|> return t1 


parseAtomType :: Parser Type
parseAtomType = parseTBool <|> do
    _ <- char '('
    t <- parseType
    _ <- char ')'
    return t

parseTBool :: Parser Type
parseTBool = do
    space 
    type0 <- string "Bool"
    space 
    return TBool


parseExpr :: Parser Expr
parseExpr = do
    
    term <-  parseTerm

    space 

    -- Aqui a gente verifica se existe tem ':' se tiver entao a gente retorna um tipo Ann se n tiver a gente so retorna 
    -- o term
    (do 
        _ <- char ':'
        type0 <- parseType 
        return (Ann term type0)
     ) <|> return term
