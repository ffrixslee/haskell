--module Main where
    
import Test.QuickCheck
import Test.QuickCheck.Gen (oneof)

{-
data Trivial = 
    Trivial
    deriving (Eq, Show)

trivialGen :: Gen Trivial
trivialGen = 
    return Trivial

instance Arbitrary Trivial where 
    arbitrary = trivialGen

main :: IO ()
main = do
    sample trivialGen
-}

{-
data Identity a = 
    Identity a
    deriving (Eq, Show)

identityGen :: Arbitrary a => 
               Gen (Identity a)
identityGen = do
    a <- arbitrary
    return (Identity a)

-- its like a template
instance Arbitrary a => 
         Arbitrary (Identity a) where
    arbitrary = identityGen

-- now you fill in with a more concrete type
identityGenInt :: Gen (Identity Int)
identityGenInt = identityGen

-}
{-
data Pair a b =
    Pair a b
    deriving (Eq, Show)

pairGen :: (Arbitrary a, Arbitrary b) =>
            Gen (Pair a b)

pairGen = do
    a <- arbitrary
    b <- arbitrary
    return (Pair a b)

-- again, it's like a template
instance (Arbitrary a, Arbitrary b) =>
          Arbitrary (Pair a b) where
    arbitrary = pairGen

-- again, now you fill in with more concrete types
pairGenIntString :: Gen (Pair Int String)
pairGenIntString = pairGen
-}

{-
data Sum a b =
    First a 
  | Second b
  deriving (Eq, Show)

-- equal odds for each
sumGenEqual :: (Arbitrary a,
                Arbitrary b) =>
                Gen (Sum a b)

sumGenEqual = do
    a <- arbitrary
    b <- arbitrary
    oneof [return $ First a,
           return $ Second b]

sumGenCharInt :: Gen (Sum Char Int)
sumGenCharInt = sumGenEqual

-}

{-

-- Maybe instance

instance Arbitrary a => 
         Arbitrary (Maybe a) where
    arbitrary =
        frequency [(1, return Nothing),
                    (3, liftM Just arbitrary)]
-}

{-
data Sum a b =
    First a
  | Second b
  deriving (Eq, Show)

sumGenFirstPls :: (Arbitrary a, 
                   Arbitrary b) =>
                   Gen (Sum a b)

sumGenFirstPls = do 
    a <- arbitrary
    b <- arbitrary
    frequency [(10, return $ First a),
                (1, return $ Second b)]

instance (Arbitrary a, Arbitrary b) =>
          Arbitrary (Sum a b) where
    arbitrary = sumGenFirstPls

sumGenCharIntFirst :: Gen (Sum Char Int)
sumGenCharIntFirst = sumGenFirstPls
-}