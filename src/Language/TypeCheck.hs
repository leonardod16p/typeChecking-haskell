module Language.TypeCheck (inferType, checkType,  Context) where

import qualified Data.Map as M
import Language.Types 


type Context = M.Map String Type 


-- Typing Rules
-- Parece que ele foca nas regras de tipo dos tipos Booleanos
-- Por exemplo, ele "modela" a partir das regras (BT-VAR), (BT-True), ...
-- BT = Boolean Type 

-- lookup :: Name -> Context -> Maybe Type 
-- Para inferir o tipo de uma variavel, precisamos apenas olhar para essa variavel no contexto



inferType :: Context -> Expr -> Maybe Type
inferType ctx expr = case expr of 

    (Var x) -> M.lookup x ctx

    (LitBool b) -> return TBool 

-- "We can determine the type of a type annotation by simply reading the annotation.
-- Thus, typing annotations provide a means of switching from checking mode to inference mode"

    (Ann t ty) -> do
        _ <- checkType ctx t ty
        return ty

    -- Primeiro eu checko se App Function x tem o mesmo tipo que TArrow t1 t2
    -- check ctx f 

    (App f x) -> do
        fType <- inferType ctx f 
        -- desempacoto o tipo inferido e caso padroes
        case fType of  
            -- se bater com TArrow t1 t2 entao a gente retorna t2
            (TArrow t1 t2) -> do
                _ <- (checkType ctx x t1)
                Just t2
            _ -> Nothing
    
    _ -> Nothing

-- Agora que temos de fora os casos triviais, vamos nos ater a interacao entre a  inferencia e os modos de checkagem
-- Se nos podemos inferir o tipo de um termo, entao nos podemos checkar contra um tipo
-- Ou seja, a ideia eh q a gente infere o tipo do termo pelo contexto. Agora a gente so precisa comparar essa inferencia
-- com os tipos definidos
-- Ele enuncia a regra (BT-CheckInfer)



checkType :: Context -> Expr -> Type -> Maybe Type
checkType ctx expr ty = 
    case (expr, ty) of 

        (If t1 t2 t3, ty) -> 
            case (checkType ctx t1 TBool, checkType ctx t2 ty, checkType ctx t3 ty) of 
                (Just TBool, Just ty2, Just ty3) -> if ty2 == ty3 then Just ty else Nothing
                _ -> Nothing  

        (Lambda x body, TArrow t1 t2) ->      
            -- Pegamos o padrao ctx, abstracao lambda com argumento x e resto body
            -- Vamos inserir no contexto Context o argumento com o tipo associado 
            let ctx1 = M.insert x t1 ctx 
            -- vamos checkar o body com o t2
            in checkType ctx1 body t2

        -- Talvez eu so precise pegar o tipo dessa funcao no contexto
        -- A ideia eh q a gente ta anotando os tipos


        -- Se nenhum padrao anterior bater, vamo de checkagem generica
        _ -> case inferType ctx expr of 
            (Just ty1) -> if ty == ty1 
                then Just ty
                else Nothing
            _ -> Nothing
