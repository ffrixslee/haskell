import Control.Applicative
import Data.List (elemIndex)

-- Exercises: Lookups

-- 1.
added :: Maybe Integer
added = 
    (+3) <$> (lookup 3 $ zip [1,2,3][4,5,6])

-- 2.
y :: Maybe Integer
y = lookup 3 $ zip [1,2,3][4,5,6]

z :: Maybe Integer
z =lookup 2 $ zip [1,2,3][4,5,6]

tupled :: Maybe (Integer, Integer)
tupled = (,) <$> y <*> z

-- 3. 
-- elemIndex finds the index position of the value being searched for

x :: Maybe Int
x = elemIndex 3 [1,2,3,4,5]

y' :: Maybe Int
y' = elemIndex 4 [1,2,3,4,5]

max' :: Int -> Int -> Int
max' = max

maxed :: Maybe Int
maxed = max' <$> x <*> y'

-- 4. 
xs = [1,2,3]
ys = [4,5,6]

x' :: Maybe Integer
x' = lookup 3 $ zip xs ys

y'' :: Maybe Integer
y'' = lookup 2 $ zip xs ys

summed :: Maybe Integer
summed = fmap sum $ (,) <$> x' <*> y''

-- Exercise: Identity instance

newtype Identity a = Identity a
    deriving (Eq, Ord, Show)

instance Functor Identity where
    fmap f (Identity x) = Identity (f x)

instance Applicative Identity where
    pure = Identity
    (<*>) (Identity x) (Identity y) = (Identity x) <*> (Identity y)

-- Exercise: Constant instance

newtype Constant a b =
    Constant { getConstant :: a }
    deriving (Eq, Ord, Show)

instance Functor (Constant a) where
    fmap _ (Constant x) = Constant x

instance Monoid a 
      => Applicative (Constant a) where
    pure _ = Constant mempty
    (<*>) (Constant x) (Constant y) = Constant (x `mappend` y)