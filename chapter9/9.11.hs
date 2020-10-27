zipList :: [a] -> [b] -> [(a, b)]  
zipList _ [] = []
zipList (x:xs) (y:ys) = (x,y) : zipList xs ys


zipWithMe :: (a -> b -> c)  
          -> [a] -> [b] -> [c]  
zipWithMe _ _ [] = []
zipWithMe f (a:as) (b:bs) = f a b : zipWithMe f as bs

zipList'  = zipWithMe (,)