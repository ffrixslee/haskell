module Main where

import Control.Monad
import Text.ParserCombinators.Parsec hiding (spaces)
import System.Environment
-- hide spaces because name conflicts with a function that we'll be defining later.

-- define data type that can be traversed and parsed later
data LispVal = Atom String
             | List [LispVal]
             | DottedList [LispVal] LispVal
             | Number Integer
             | String String
             | Bool Bool

symbol :: Parser Char
symbol = oneOf "!#$%&|*+-/:<=>?@^_~"
-- oneOf will recognize a single one of any of the characters in the string passed to it

-- define a function to call our parser and handle any possible errors:

readExpr :: String -> String
readExpr input = case parse parseExpr "lisp" input of
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


parseString :: Parser LispVal 
parseString = do 
                char '"'
                x <- many (noneOf "\"")
                char '"'
                return $ String x
-- return : lifts a value into the Monad. Thus it lets us wrap the LispVal in a Parser action that consumes no input but returns it as the inner value.

{-
>> : if actions don't return a value
>>= : if immediately passing that value into the next action
do- notation: otherwise
-}

parseAtom :: Parser LispVal
parseAtom = do
              first <- letter <|> symbol 
              rest <- many (letter <|> digit <|> symbol)
              let atom = first:rest
              return $ case atom of
                        "#t" -> Bool True
                        "#f" -> Bool False
                        _    -> Atom atom

-- <|> : if first parser fails, then it tries the second parser
-- _ : wildcard
-- alternatively: [first] ++ rest

-- create a parser for numbers:
{-
parseNumber :: Parser LispVal
parseNumber = liftM (Number . read) $ many1 digit
-}

parseNumber :: Parser LispVal
parseNumber = do
    x <- many1 digit 
    return (Number . read) x


parseExpr :: Parser LispVal
parseExpr = parseAtom 
         <|> parseString
         <|> parseNumber

main :: IO ()
main = do 
          (expr:_) <- getArgs
          putStrLn (readExpr expr)

-- Exercises
-- 1. Rewrite parseNumber, without liftM, using
--   1. do-notation
--   2. explicit sequencing with the >>= operator