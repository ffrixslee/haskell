module Cipher where
import Data.Char

--for simplicity use ord and chr to associate a Char with its Int


{- cipherNum :: Int -> Char -> Int
cipherNum x b = x + ord b
--cipherChar x b = chr (ord b + x)
cipherChar :: Int -> Char -> Char
cipherChar x b = chr (cipherNum x b)
-}

--x = x `mod` 122 


x :: [a]
x = [b | x<- mod b 123 ,b<-[97..122]]

{-
module Cipher where
import Data.Char
 
caeser :: String -> Int ->String
caeser s n = map (shiftRight n) s
 
unCaeser :: String -> Int ->String
unCaeser s n = caeser s (26 - n)
 
shiftRight :: Int -> Char -> Char
shiftRight n c
    | isUpper c = wrapChar (ord 'A') n c
    | isLower c = wrapChar (ord 'a') n c
    | otherwise = c
 
wrapChar :: Int -> Int -> Char -> Char
wrapChar start offSet c = chr (start + (ord c + offSet - start) `mod` 26)
-}