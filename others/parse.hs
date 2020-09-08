import Text.ParserCombinators.Parsec
import Control.Applicative
import Data.Char

newType Parser a = P (String -> [(a,String)])

parse :: Parser a -> String -> [(a,String)]



type Parser a = String ->[(a,String)]
Parser digit "123"
