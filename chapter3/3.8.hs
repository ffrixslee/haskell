module Reverse where

rvrs :: String -> String
rvrs x = drop 9 x ++ " is " ++ take 5 x

main :: IO()
main = print $ rvrs "Curry is awesome"

