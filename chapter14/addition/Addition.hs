module Addition where

import Test.Hspec
import Test.QuickCheck

{-
sayHello :: IO()
sayHello = putStrLn "hello!"
-}

main :: IO ()
main = hspec $ do
    describe "Addition" $ do 
        it "1 + 1 is greater than 1" $ do
            (1 + 1) > 1 `shouldBe` True
        it "2 + 2 is equal to 4" $ do
            2 + 2 `shouldBe` 4
        it "15 dividedBy 3 is 5" $ do
            dividedBy 15 3 `shouldBe` (5,0)
        it "22 divided by 5 is\
            \ 4 remainder 2" $ do
            dividedBy 22 5 `shouldBe` (4,2)
        it "3 multiplied by 2 is 6" $ do
            mult1 3 2 `shouldBe` 6
        it "x + 1 is always\
            \ greater than x" $ do
            property $ \x -> x + 1 > (x :: Int)

dividedBy :: Integral a => a -> a -> (a, a)
dividedBy num denom = go num denom 0
    where go n d count
            | n < d = (count, n)
            | otherwise =
                go (n - d) d (count + 1)

mult1 :: (Integral a) => a -> a -> a
mult1 x y = go x y
  where go x y
          | y == 0 = 0
          | otherwise = x + (mult1 x(y-1))

trivialInt :: Gen Int
trivialInt = return 1

--return :: Monad m => a -> m a

-- when m is Gen:
-- return :: a -> Gen a

oneThroughThree :: Gen Int
oneThroughThree = elements [1, 2, 2, 2, 3]

genBool :: Gen Bool
genBool = choose (False, True)

genBool' :: Gen Bool
genBool' = elements [False, True]

genOrdering :: Gen Ordering
genOrdering = elements [LT, EQ, GT]

genChar :: Gen Char
genChar = elements ['a'..'z']

genTuple :: (Arbitrary a, Arbitrary b)
         => Gen (a, b)
genTuple = do
    a <- arbitrary
    b <- arbitrary
    return (a, b)

genThreeple :: (Arbitrary a, Arbitrary b, Arbitrary c)
            => Gen (a, b, c)
genThreeple = do 
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return (a, b, c)

--type G = Gen (Int, Float)
--type G = Gen (Int, String, Float)
--type G = Gen (Either Int Float)
--type G = Gen (Maybe Float)

genEither :: (Arbitrary a, Arbitrary b)
          => Gen (Either a b)
genEither = do
    a <- arbitrary
    b <- arbitrary
    elements [Left a, Right b]

-- equal probability
genMaybe :: Arbitrary a => Gen (Maybe a)
genMaybe = do 
    a <- arbitrary
    elements [Nothing, Just a]

genMaybe' :: Arbitrary a => Gen (Maybe a)
genMaybe' = do
    a <- arbitrary
    frequency [ (1, return Nothing)
              , (3, return (Just a))]

-- frequency :: [(Int, Gen a)] -> Gen a

-- Using QuickCheck without Hspec
prop_additionGreater :: Int -> Bool
prop_additionGreater x = x + 1 > x

runQc :: IO ()
runQc = quickCheck prop_additionGreater