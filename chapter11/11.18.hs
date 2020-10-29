--capitalizeWords :: String -> [(String, String)]
module Vignere where
import Data.Char

{-
cipherNum :: Int -> Char -> Int
cipherNum n x = n + ord x
cipherChar :: Int -> Char -> Char
cipherChar x b = chr (cipherNum x b) 

wrapAround :: Int -> Char -> Char
wrapAround n x = chr ( (ord x + n) `mod` 122)

shiftRight :: Int -> Char -> Char
shiftRight n x
    | isUpper x = wrapAround (ord 'A') x
    | isLower x = wrapAround (ord 'a') x
    | otherwise = x

caeser :: String -> Int ->String
caeser s n = map (shiftRight n) s
 
unCaeser :: String -> Int ->String
unCaeser s n = caeser s (122 - n)
-}
encrypt :: Int -> Char -> Int
encrypt n c = n + ord c  

decrypt :: Int -> Char -> Char
decrypt n c = chr (encrypt n c )

wrapAround n c = chr ( (ord c + n) `mod` 122)

keyword c x
    | x = 'A' == 0
    | x = 'L' == 11
    | x = 'Y' == 24

    
chr (ord 'M' + 0)
chr (ord 'E' + 11)
chr (ord 'E' + 11)
toUpper $ chr ( (ord 'T' + 30) `mod` 122)

chr (ord 'A' + 0)
toUpper $ chr ( (ord 'T' + 17) `mod` 122)

chr (ord 'D' + 11)
chr (ord 'A' + 24)
chr (ord 'W' + 0)
chr (ord 'N' + 11)

