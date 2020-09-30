module WordNumber where
import Data.List (intersperse)
 
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
    9 -> "none"
    _ -> ""
 
digits :: Int -> [Int]
digits n = go n []
    where go n ds
              | n  String
digitToWord n = concat $ intersperse "-" digitWords
    where digitWords = map digitToWord $ digits n