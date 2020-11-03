{-
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

--Alternatively: 
digits n = enumFromTo 0 9

wordNumber = concat $ intersperse "-" digitsWord
 where digitsWord  = map digitToWord $ digits 1
-}

module WordNumber where
import           Data.List (intersperse)

digitToWord :: Int -> String
digitToWord n = case n of
    0 -> "zero"
    1 -> "one"
    2 -> "two"
    3 -> "three"
    4 -> "four"
    5 -> "five"
    6 -> "six"
    7 -> "seven"
    8 -> "eight"
    9 -> "nine"
    _ -> ""

digits :: Int -> [Int]
digits n = go n []
    where go n ds
              | n < 10    = n : ds
              | otherwise = go d (m : ds)
              where (d,m) = n `divMod` 10

wordNumber :: Int -> String
wordNumber = concat . intersperse "-" . map digitToWord . digits
-- wordNumber x = concat . intersperse "-" . digitWords
--     where digitWords = map digitToWord . digits
