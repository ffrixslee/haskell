import Data.Foldable 
import Data.Monoid

-- all folding functions depend on monoidal instances
-- this is because folding implies a binary associative operation that has an identity value, which is what a monoid is.


-- 1. 

-- foldMap:
sum' :: (Foldable t, Num a) => t a -> a
sum' x = getSum $ foldMap Sum x 
-- Note: foldMap folds it into a summary Monoid value

-- foldr:
sum'' :: (Foldable t, Num a) => t a -> a
sum'' y =  foldr (+) 0 y

-- 2. 

-- foldMap:
product' :: (Foldable t, Num a) => t a -> a
product' x = getProduct $ foldMap Product x 

-- foldr:
product'' :: (Foldable t, Num a) => t a -> a
product'' x = foldr (*) 1 x

-- 3.

-- foldMap:
elem' :: (Foldable t, Eq a) 
      => a -> t a -> Bool
elem' x = getAny . foldMap (Any . (== x))

-- foldr:
elem'' :: (Foldable t, Eq a) 
      => a -> t a -> Bool
--elem'' ys  = (any (\x-> x == ys))
elem'' e = foldr (\x acc -> acc || x == e) False

-- 4. 

-- foldr:
minimum' :: (Foldable t, Ord a) => t a -> Maybe a
minimum' = foldr fmin Nothing
  where fmin x Nothing = Just x
        fmin x (Just y) = Just (min x y)

-- 5.

-- foldr:
maximum' :: (Foldable t, Ord a) => t a -> Maybe a
maximum' = foldr fmax Nothing
  where fmax x Nothing  = Just x
        fmax x (Just y) = Just (max x y)

-- 6.

-- foldr:
null' :: (Foldable t) => t a -> Bool
null' = foldr (\_ _ -> False) True

-- foldMap:
null'' :: (Foldable t) => t a -> Bool
null'' = getAll . foldMap (\_ -> All False)

-- 7.

-- foldr:
length' :: (Foldable t) => t a -> Int
length' = foldr (\_ acc -> acc + 1) 0

-- foldMap:
length'' :: (Foldable t) => t a -> Int
length'' = getSum . foldMap (\_ -> Sum 1)

-- 8.

-- foldr:
toList' :: (Foldable t) => t a -> [a]
toList' = foldr (\x acc -> x : acc) []

-- foldMap:
toList'' :: (Foldable t) => t a -> [a]
toList'' = foldMap (\x -> [x])

-- 9.

-- foldMap:
fold' :: (Foldable t, Monoid m) => t m -> m
fold' = foldMap (id)

-- 10. 

-- foldr:
foldMap' :: (Foldable t, Monoid m) => (a -> m) -> t a -> m
foldMap' f = foldr (\x acc -> (f x) <> acc) mempty
