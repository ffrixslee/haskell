myHead (x : _) = x
myTail :: [a] -> [a]
myTail (_ : xs) = xs
myTail [] = []

safeTail :: [a] -> Maybe [a]
safeTail [] = Nothing
safeTail (_:[]) = Nothing
safeTail (_:xs) = Just xs