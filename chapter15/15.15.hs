module Mon2 where

import Control.Monad
import Data.Monoid
import Data.Semigroup
import Test.QuickCheck

{-
data Trivial = Trivial deriving (Eq, Show)  

instance Semigroup Trivial where  
    _ <> Trivial = Trivial 
instance Arbitrary Trivial where  
    arbitrary = return Trivial  
semigroupAssoc :: (Eq m, Semigroup m)  
               => m -> m -> m -> Bool  
semigroupAssoc a b c =  
    (a <> (b <> c)) == ((a <> b) <> c)  
type TrivAssoc =  
    Trivial -> Trivial -> Trivial -> Bool  
main :: IO ()  
main =  
    quickCheck (semigroupAssoc :: TrivAssoc)  
-}

{-
newtype Identity a = Identity a deriving (Eq, Show)
instance Semigroup a => Semigroup (Identity a) where
    (Identity x) <> (Identity y) = Identity (x <> y)
instance Arbitrary a => Arbitrary (Identity a) where
    arbitrary = do Identity <$> arbitrary 
type IdTest = Identity String
type IdAssoc =  
    IdTest -> IdTest -> IdTest -> Bool  
main :: IO ()  
main =  
    quickCheck (arbitrary :: IdTest)
-}

data Two a b = Two a b deriving (Eq, Show)

--type TwoTest = Two String [Int]
--type TwoAssoc =  TwoTest -> TwoTest -> TwoTest -> Bool
 
instance (Semigroup a, Semigroup b) => Semigroup (Two a b) where
    (Two a b) <> (Two a' b') = Two (a <> a') (b <> b')
 
instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
    arbitrary = do
      a <- arbitrary
      b <- arbitrary
      return (Two a b)

type TwoAssoc = Two String [Int] -> Two String [Int] -> Two String [Int] -> Bool
{-
data Three a b c = Three a b c

threeGen :: (Arbitrary a, Arbitrary b, Arbitrary c)
            => Gen (Three a b c)
threeGen = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return (a, b, c)

type ThreeTest = Three Int Char String
type ThreeAssoc = ThreeTest -> ThreeTest -> ThreeTest -> ThreeTest -> Bool

instance (Semigroup a, Semigroup b, Semigroup c) => Gen (Three a b c) where
    (Three a b c) <> (Three a' b' c') <> (Three a'' b'' c'') = Three (a a' a'')
-}
