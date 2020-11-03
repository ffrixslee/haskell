{-
-- Validating numbers into words
module WordNumberTest where

import Test.Hspec
import WordNumber
  (digitToWord, digits, wordNumber)

main :: IO ()
main = hspec $ do
  describe "digitToWord" $ do
    it "returns zero for 0" $ do
      digitToWord 0 `shouldBe` "zero"
    it "returns one for 1" $ do
      digitToWord 1 `shouldBe` "one"
      
  describe "digits" $ do
    it "returns [1] for 1" $ do
      digits 1 `shouldBe` [1]
    it "returns [1, 0, 0] for 100" $ do
      digits 100 `shouldBe` [1,0,0]

  describe "wordNumber" $ do
    it "one-zero-zero given 100" $ do
      wordNumber 100 `shouldBe` "one-zero-zero"

    it "nine-zero-zero-one for 9001" $ do
      wordNumber 9001 `shouldBe` "nine-zero-zero-one" 
-}

-- Using QuickCheck

{-
half :: Fractional a => a -> a
half x = x / 2
 
halfIdentity :: Fractional a => a -> a
halfIdentity = (*2) . half
 
prop_Half :: (Eq a, Fractional a) => a -> Bool
prop_Half x = halfIdentity x == x
-}

import Data.List (sort)
-- for any list you apply sort to,
-- this property should hold

listOrdered :: (Ord a) => [a] -> Bool
listOrdered xs =
    snd $ foldr go (Nothing, True) xs
    where go _ status@(_, False) = status
          go y (Nothing, t) = (Just y, t)
          go y (Just x, t) = (Just y, x >= y)

-- Not sure whether listOrdered True means xs == sort xs 
propSort :: (Ord a) => [a] -> Bool
propSort xs | listOrdered xs = xs == sort xs
            | otherwise      = not (xs == sort xs)
 
-- ... or if xs == sort xs means listOrdered is True
propSort' :: (Ord a) => [a] -> Bool
propSort' xs | xs == sort xs = listOrdered xs
             | otherwise     = not $ listOrdered xs

plusAssociative :: (Eq a, Num a) => a -> a -> a -> Bool
plusAssociative x y z = x + (y + z) == (x + y) + z
 
plusCommutative :: (Eq a, Num a) => a -> a -> Bool
plusCommutative x y = x + y == y + x
 
plusIntegerAssociative :: Integer -> Integer -> Integer -> Bool
plusIntegerAssociative = plusAssociative
 
plusWordCommutative :: Word -> Word -> Bool
plusWordCommutative = plusCommutative

mulAssociative :: (Eq a, Num a) => a -> a -> a -> Bool
mulAssociative x y z = x + (y + z) == (x + y) + z
 
mulCommutative :: (Eq a, Num a) => a -> a -> Bool
mulCommutative x y = x + y == y + x
 
mulIntAssociative :: Int -> Int -> Int -> Bool
mulIntAssociative = mulAssociative
 
mulDoubleCommutative :: Double -> Double -> Bool
mulDoubleCommutative = mulCommutative

rop_DivMod :: Integral a => a -> (NonZero a) -> Bool
prop_DivMod x (NonZero y) =  (div  x y)*y + (mod x y) == x
 
prop_QuotRem :: Integral a => a -> (NonZero a) -> Bool
prop_QuotRem x (NonZero y) = (quot x y)*y + (rem x y) == x

main :: IO ()
main = do
  quickCheck (prop_DivMod :: Word -> NonZero Word -> Bool)
  quickCheck (prop_QuotRem :: Int -> NonZero Int -> Bool)
  quickCheck (prop_DivMod :: Integer -> NonZero Integer -> Bool)

exponentialAssociative :: Integral a => a -> a -> a -> Bool
exponentialAssociative x y z = x ^ (y ^ z) == (x ^ y) ^ z
 
exponentialCommutative :: Integral a => a -> a -> Bool
exponentialCommutative x y = x ^ y == y ^ x

prop_Reverse :: Eq a => [a] -> Bool
prop_Reverse xs = id xs == (reverse . reverse) xs

prop_Apply :: Eq b => (a -> b) -> a  -> Bool
prop_Apply f x = f x == (f $ x) -- why not? f x == f $ x ??
 
prop_Dollar :: Eq b => Fun a b -> a  -> Bool
prop_Dollar (Fn f) x = (f x) == (f $ x)
 
prop_Compose :: Eq c => (Fun b c) -> (Fun a b) -> a -> Bool
prop_Compose (Fn f) (Fn g) x = f (g x) == ((f . g) x)

prop_FoldAppend :: Eq a => [a] -> [a] -> Bool
prop_FoldAppend xs ys = foldr (:) xs ys == xs ++ ys
 
prop_FoldConcat :: Eq a => [[a]] -> Bool
prop_FoldConcat xss = foldr (++) [] xss == concat xss

prop_TakeLength :: Int -> [a] -> Bool
prop_TakeLength n xs = length (take n xs) == n

rop_staysCapitalised :: String -> Bool
prop_staysCapitalised x = capitalised == twice capitaliseWord x &&
                     capitalised == fourTimes capitaliseWord x
    where capitalised = capitaliseWord x
