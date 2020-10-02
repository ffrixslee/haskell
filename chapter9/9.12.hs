import Data.Char

filterUp :: String -> String
filterUp (x:xs) = filter isUpper (x:xs)

capFstLetter :: String -> String
capFstLetter (x:xs) = toUpper x : xs

capAll :: String -> String
capAll [] = []
capAll (x:xs) = toUpper x : capAll xs

capLetter :: [Char] -> Char
capLetter (n:ns) = toUpper $ head (n:ns)

capLetter' :: [Char] -> Char
capLetter' (n:ns) = toUpper . head $ (n:ns)

capLetter'' :: [Char] -> Char
capLetter'' = toUpper . head 

