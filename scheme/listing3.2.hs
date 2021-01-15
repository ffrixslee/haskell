module Main where

import Text.ParserCombinators.Parsec hiding (spaces)
import System.Environment

-- hide spaces because name conflicts with a function that we'll be defining later.

symbol :: Parser Char
symbol = oneOf "!#$%&|*+-/:<=>?@^_~"
-- oneOf will recognize a single one of any of the characters in the string passed to it

-- define a function to call our parser and handle any possible errors:

readExpr :: String -> String
readExpr input = case parse (spaces >> symbol) "lisp" input of
    Left err -> "No match" ++ show err
    Right val -> "Found value"
{-
input  : parameter name
symbol : parser that is an argument to the Parsec function parse
"lisp" : name for the input, used for error messages
-}

-- (read: lexeme parser)
spaces :: Parser ()
spaces = skipMany1 space

main :: IO ()
main = do 
          (expr:_) <- getArgs
          putStrLn (readExpr expr)
