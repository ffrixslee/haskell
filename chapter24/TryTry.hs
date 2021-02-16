module TryTry where

import Text.Trifecta
import Data.Ratio ((%))
import Control.Applicative

-- making a parser that can parse either decimals or fractions

parseFraction :: Parser Rational
parseFraction = do
    numerator <- decimal
    char '/'
    denominator <- decimal
    return (numerator % denominator)

type FractionsOrDecimals = Either Rational Integer

parseFD :: Parser FractionsOrDecimals
parseFD = try (Left <$> parseFraction) <|> (Right <$> decimal )

testParse :: IO()
testParse = do
    print $ parseString parseFD mempty "3/4"
    print $ parseString parseFD mempty "23"

-- try out try function !