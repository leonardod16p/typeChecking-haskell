-- ADTs tipo algebrico de dados
-- O que cada um deles pode ser?

module Language.Types where

type Name = String

data Expr = Var Name              -- Uma variavel do tipo string
          | LitBool Bool            -- um valor booleano 
          | Lambda String Expr         -- Uma abstracao lambda \x. t
          | App Expr Expr           -- uma aplicacao e e
          | If Expr Expr Expr       -- um condicional if then else 
          | Ann Expr Type           -- uma anotacao para monitorar o tipo de uma expressao
          deriving (Show) 


data Type 
    = TBool             -- o tipo Bool 
    | TArrow Type Type  -- o tipo Funcao (t1 -> t2) 
    deriving (Show, Eq)
