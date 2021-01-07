module FunC where

import Test.QuickCheck
import Test.QuickCheck.Function (Fun(..))
import FuncProp

-- 1.
newtype Identity a = Identity a
        deriving (Eq, Show)

instance Functor Identity where
    fmap f (Identity x) = Identity (f x)

instance Arbitrary a => Arbitrary (Identity a) where
    arbitrary = do
        x <- arbitrary
        return $ Identity x

--type IntToInt = Fun Int Int
type IntToChar = Fun Int Char
type CharToBool = Fun Char Bool

type IdTest = Identity Int

-- 2.
data Pair a = Pair a a
     deriving (Eq, Show)

instance Functor Pair where
    fmap f (Pair x x') = Pair (f x) (f x')

instance Arbitrary a => Arbitrary (Pair a) where
    arbitrary = do 
        x1 <- arbitrary
        x2 <- arbitrary
        return $ Pair x1 x2

type PairTest = Pair Int


-- leave the Left value alone, and only apply function to the right values
-- 3. 
data Two a b = Two a b
     deriving (Eq, Show)

instance Functor (Two a) where
    fmap f (Two a b) = Two a (f b)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
    arbitrary = do 
        a <- arbitrary
        b <- arbitrary
        return $ Two a b

type TwoTest = Two Int Int


-- Similarly, leave the Left value alone
-- 4.
data Three a b c = Three a b c 
     deriving (Eq, Show)

instance Functor (Three a b) where
    fmap f (Three x y z) = Three x y (f z)

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        c <- arbitrary
        return $ Three a b c

type ThreeTest = Three Int Int Int

-- 5.
data Three' a b = Three' a b b 
     deriving (Eq, Show)

instance Functor (Three' a) where
    fmap f (Three' x y y') = Three' x (f y) (f y') 

instance (Arbitrary a, Arbitrary b) => Arbitrary (Three' a b) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        return $ Three' a b b 

type ThreeTest' = Three' Int Char

-- 6. 
data Four a b c d = Four a b c d 
     deriving (Eq, Show)

instance Functor (Four a b c ) where
    fmap f (Four a b c d) = Four a b c (f d)

instance (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Arbitrary (Four a b c d) where
    arbitrary = do 
        a <- arbitrary
        b <- arbitrary
        c <- arbitrary
        d <- arbitrary
        return $ Four a b c d

type FourTest = Four Int Char Int Char

-- 7.
data Four' a b = Four' a a a b
     deriving  (Eq, Show)

instance Functor (Four' a ) where
    fmap f (Four' x x' x'' y) = Four' x x' x'' (f y)  

instance (Arbitrary a, Arbitrary b) => Arbitrary (Four' a b) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        return $ Four' a a a b

type FourTest' = Four' Int Char

-- 8.
data Trivial = Trivial 
     deriving (Eq, Show) 

-- No, it can't be implemented because Trivial has kind * and not * -> *

-- tests:
tests :: IO()
tests = do
    quickCheck (functorIdentity :: IdTest -> Bool)
    --quickCheck (functorCompose  :: IntToChar -> CharToBool ->  IdTest -> Bool )
    quickCheck (functorIdentity :: PairTest -> Bool)
    --quickCheck (functorCompose :: IntToChar -> CharToBool -> PairTest -> Bool)
    quickCheck (functorIdentity :: TwoTest -> Bool)
    quickCheck (functorIdentity :: ThreeTest -> Bool)
    quickCheck (functorIdentity :: ThreeTest' -> Bool)
    quickCheck (functorIdentity :: FourTest -> Bool)
    quickCheck (functorIdentity :: FourTest' -> Bool)


