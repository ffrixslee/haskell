seekritFunc :: String -> Int
seekritFunc x = (sum (map length (words x))) / (length (words x))