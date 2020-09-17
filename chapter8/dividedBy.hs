dividedBy :: Integral a => a -> a -> (a, a)
data DividedResult = Result Integer
                    | DividedByZero

dividedBy num denom = go num denom 0
    where go n d count
            | n < d = (count, n)
            | otherwise = 
                go (n - d) d (count + 1)