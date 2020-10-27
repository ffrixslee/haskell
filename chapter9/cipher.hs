module Cipher where
import Data.Char


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
