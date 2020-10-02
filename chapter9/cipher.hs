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