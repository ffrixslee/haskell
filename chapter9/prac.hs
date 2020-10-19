{-
myHead (x : _) = x
myTail :: [a] -> [a]
myTail (_ : xs) = xs
myTail [] = []

safeTail :: [a] -> Maybe [a]
safeTail [] = Nothing
safeTail (_:[]) = Nothing
safeTail (_:xs) = Just xs
-}

{-
myOr :: [Bool] -> Bool  
myOr [] = False  
myOr (x:xs) =  
    if x == True then True  
    else myOr xs 
-}

{-
myOr :: [Bool] -> Bool
myOr [] = False
myOr (x:xs) = x || myOr xs
-}

{-
myAny :: (a -> Bool) -> [a] -> Bool
myAny f [] = False
myAny f (x:xs) = f x || myAny f xs
-}

{-
myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem b (x:xs) = b == x || myElem b xs
-}

{-
myElem' :: Eq a => a -> [a] -> Bool
myElem' x xs = any (== x) xs
-}

{-
myReverse :: [a] -> [a]
myReverse (x:xs) = reverse (x:xs)
-}

{-
squish :: [[a]] -> [a]
squish [] = []
squish (y:ys) = y ++ squish ys
-}

{-
squishMap :: (a -> [b]) -> [a] -> [b] 
squishMap _ [] = []
squishMap f (x:xs) = f x ++ squishMap f xs 


squishAgain :: [[a]] -> [a]
squishAgain = squishMap id
-}

{-
myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy _ [] = error "myMaximumBy - empty list"
myMaximumBy _ [x] = x
myMaximumBy f (x1:x2:xs) =
    case f x1 x2 of
      GT -> myMaximumBy f (x1:xs)
      _  -> myMaximumBy f (x2:xs)
-}

{-
myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy _ [] = error "myMaximumBy - empty list"
myMinimumBy _ [x] = x
myMinimumBy f (x1:x2:xs) =
    case f x1 x2 of
      LT -> myMinimumBy f (x1:xs)
      _  -> myMinimumBy f (x2:xs)
-}

{-
myMaximum :: (Ord a) => [a] -> a
myMaximum = myMaximumBy compare
 
myMinimum :: (Ord a) => [a] -> a
myMinimum = myMinimumBy compare
-}