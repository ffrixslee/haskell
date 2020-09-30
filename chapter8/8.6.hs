{- mult1 :: (Integral a) => a -> a -> a
mult1 x y = go x y
  where go x y
          | y == 0 = 0
          | otherwise = x + (mult1 x(y-1))
-}

--fix the function to handle division by zero -> error
{-
data DividedResult =
      Result Integer
    | DividedByZero
    --deriving Show
dividedBy :: Integer -> Integer -> DividedResult
dividedBy num 0     = error "Division by zero"
dividedBy num denom = go num denom 0
    where go n d count 
              | n < d     = Result (count)
              | otherwise = go (n - d) d (count + 1) 
-}

module WordNumber where

import Data.List (intersperse)

digitToWord :: Int -> String
digitToWord n
  | n == 0 = "zero"
  | n == 1 = "one"
  | n == 2 = "two"
  | n == 3 = "three"
  | n == 4 = "four"
  | n == 5 = "five"
  | n == 6 = "six"
  | n == 7 = "seven"
  | n == 8 = "eight"
  | n == 9 = "nine"

digits :: Int -> [Int]
digits n = [n | n <- [0..9]]
--Alternatively: digits n = enumFromTo 0 9

wordNumber = concat $ intersperse "-" digitsWord
 where digitsWord  = map digitToWord $ digits 1