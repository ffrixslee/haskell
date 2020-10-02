zipList :: [a] -> [b] -> [(a, b)]  
zipList _ [] = []
zipList (x:xs) (y:ys) = (x,y) : zipList xs ys


zipWithMe :: (a -> b -> c)  
          -> [a] -> [b] -> [c]  
zipWithMe _ _ [] = []
zipWithMe f (b:bs) (c:cs) = f b c : zipWithMe f bs cs

zipList'  = zipWithMe (,)