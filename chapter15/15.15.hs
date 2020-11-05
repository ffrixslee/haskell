module Test where

--import Control.Monad
import Data.Monoid
import Data.Semigroup
import Test.QuickCheck 
import MonoidSpec

{-
-- 1.

data Trivial = Trivial deriving (Eq, Show)

instance Semigroup Trivial where
    (<>) Trivial _ = Trivial

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

-- Just for fun:
genTrivial :: Gen Trivial
genTrivial = 
    return Trivial

-}

{-
-- 2.

newtype Identity a = Identity a deriving (Eq, Show)

instance Semigroup a => Semigroup (Identity a) where
    (<>) (Identity x) (Identity y) = Identity (x <> y) 

genId :: Arbitrary a => Gen (Identity a)
genId = do
    a <- arbitrary
    return (Identity a)
instance Arbitrary a => Arbitrary (Identity a) where
    arbitrary = genId


semigroupAssoc :: (Eq m, Semigroup m)
               => m -> m -> m -> Bool
semigroupAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)


type IdType = Identity String
type IdAssoc =
    IdType -> IdType -> IdType -> Bool

main :: IO()
main = 
    quickCheck (semigroupAssoc :: IdAssoc)


{-
--Just for fun:
genId :: Arbitrary a => Gen (Identity a)
genId = do
    a <- arbitrary
    return (Identity a)
instance Arbitrary a => Arbitrary (Identity a) where
    arbitrary = genId
identityGenInt :: Gen (Identity Int)
identityGenInt = genId
-}

-}

{-
-- 3.

data Two a b = Two a b deriving (Eq, Show)

instance (Semigroup a, Semigroup b) => Semigroup (Two a b) where
    (<>) (Two x y) (Two x' y') = Two (x <> x') (y <> y') 

genTwo :: (Arbitrary a, Arbitrary b) => Gen (Two a b)
genTwo = do
    a <- arbitrary
    b <- arbitrary
    return (Two a b) 

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
    arbitrary = genTwo

semigroupAssoc :: (Eq m, Semigroup m)
               => m -> m -> m -> Bool
semigroupAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)

type GenTwoType = Two String String
type GenTwoAssoc =
    GenTwoType -> GenTwoType -> GenTwoType -> Bool

main :: IO()
main = 
    quickCheck (semigroupAssoc :: GenTwoAssoc)

-}

{-
-- 4. 

data Three a b c = Three a b c deriving (Eq, Show)

instance (Semigroup a, Semigroup b, Semigroup c) => Semigroup (Three a b c) where
    (<>) (Three x y z) (Three x' y' z') = Three (x <> x') (y <> y') (z <> z') 

genThree :: (Arbitrary a, Arbitrary b, Arbitrary c) => Gen (Three a b c)
genThree = do
    a <- arbitrary
    b <-arbitrary
    c <-arbitrary
    return (Three a b c)

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
    arbitrary = genThree

semigroupAssoc :: (Eq m, Semigroup m)
               => m -> m -> m -> Bool
semigroupAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)

type GenThreeType = Three String String String
type GenThreeAssoc = 
    GenThreeType -> GenThreeType -> GenThreeType -> Bool

main :: IO()
main = 
    quickCheck (semigroupAssoc :: GenThreeAssoc)

-}

{-
-- 5.

data Four a b c d = Four a b c d deriving (Eq, Show)

instance (Semigroup a, Semigroup b, Semigroup c, Semigroup d) => Semigroup (Four a b c d) where
    (<>) (Four a b c d)(Four a' b' c' d') = Four (a <> a') (b <> b') (c <> c') (d <> d')

genFour :: (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Gen (Four a b c d)
genFour = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    d <- arbitrary
    return (Four a b c d)
    
instance (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Arbitrary (Four a b c d) where
    arbitrary = genFour

semigroupAssoc :: (Eq m, Semigroup m)
               => m -> m -> m -> Bool
semigroupAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)

type GenFourType = Four String Ordering String [Bool]
type GenFourAssoc =
    GenFourType -> GenFourType -> GenFourType -> Bool

main :: IO()
main = 
    quickCheck (semigroupAssoc :: GenFourAssoc)

-}

{-
-- 6.

newtype BoolConj = 
    BoolConj Bool 
    deriving (Eq, Show)

instance Semigroup BoolConj where
    (<>) (BoolConj True) (BoolConj True) = BoolConj True
    (<>) _ _ = BoolConj False

instance Arbitrary BoolConj where
    arbitrary = do
    a <- arbitrary
    return (BoolConj a)

semigroupAssoc :: (Eq m, Semigroup m)
               => m -> m -> m -> Bool
semigroupAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)

type GenBoolConjAssoc =
    BoolConj -> BoolConj -> BoolConj -> Bool

main :: IO()
main =
    quickCheck (semigroupAssoc :: GenBoolConjAssoc)
-}

{-
-- 7.

newtype BoolDisj = 
    BoolDisj Bool 
    deriving (Eq, Show)

instance Semigroup BoolDisj where
    (<>) (BoolDisj False) (BoolDisj False) = BoolDisj False
    (<>) _ _ = BoolDisj True


instance Arbitrary BoolDisj where
    arbitrary = do
        a <- arbitrary
        return (BoolDisj a)

semigroupAssoc :: (Eq m, Semigroup m)
               => m -> m -> m -> Bool
semigroupAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)

type GenBoolDisjAssoc =
    BoolDisj -> BoolDisj -> BoolDisj -> Bool

main :: IO()
main =
    quickCheck (semigroupAssoc :: GenBoolDisjAssoc)
-}

{-
-- 8.
data Or a b =
    Fst a
  | Snd b
  deriving (Eq, Show)

instance Semigroup (Or a b) where
    (<>) (Fst _) x = x
    (<>) y _ = y


genOr :: (Arbitrary a, Arbitrary b) => Gen (Or a b)
genOr = do
    a <- arbitrary
    b <- arbitrary
    elements [Fst a, Snd b]

instance (Arbitrary a, Arbitrary b) => Arbitrary (Or a b) where
    arbitrary = genOr

semigroupAssoc :: (Eq m, Semigroup m)
               => m -> m -> m -> Bool
semigroupAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)

type OrTest = Or String String
type OrAssoc =
     OrTest-> OrTest -> OrTest -> Bool

main :: IO()
main =
    quickCheck (semigroupAssoc :: OrAssoc)
-}

{-
-- 9.
newtype Combine a b =
    Combine { unCombine :: (a -> b) }

instance  Semigroup b => Semigroup (Combine a b) where
    (Combine { unCombine = f}) <> (Combine { unCombine = g}) = Combine $ \n -> f n <> g n

instance (CoArbitrary a, Arbitrary b) => Arbitrary (Combine a b) where
    arbitrary = do
        h <- arbitrary
        return $ Combine h 

semigroupAssoc :: (Eq m, Semigroup m)
               => m -> m -> m -> Bool
semigroupAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)

-- Can't seem to quickCheck the functions
-} 

{-
-- 10.

newtype Comp a = 
    Comp { unComp :: (a -> a)}
    --deriving (Eq, Show a)

instance Semigroup a => Semigroup (Comp a) where
    (Comp {unComp = f1}) <> (Comp {unComp = f2}) = Comp $ f1 . f2

instance Arbitrary a => Arbitrary (Comp a) where
    arbitrary = do
        g <- arbitrary
        return (Comp g)

semigroupAssoc :: (Eq m, Semigroup m)
               => m -> m -> m -> Bool
semigroupAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)

type CompType = Comp (String -> Bool)
type CompAssoc =
    CompType -> CompType -> CompType -> Bool

main :: IO()
main = 
    quickCheck (semigroupAssoc :: CompAssoc)

-- Also can't quickCheck the function

-}

{-
-- 11.

data Validation a b =
    Fail a | Pass b
    deriving (Eq, Show)

instance Semigroup a => 
  Semigroup (Validation a b ) where
      Pass x <> _ = Pass x
      Fail _ <> Pass y = Pass y
      Fail x <> Fail y = Fail $ x <> y

instance (Arbitrary a, Arbitrary b) => Arbitrary (Validation a b) where
    arbitrary = do
        x <- arbitrary
        y <- arbitrary
        elements [Pass x, Fail y]

semigroupAssoc :: (Eq m, Semigroup m)
               => m -> m -> m -> Bool
semigroupAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)

type ValTest = Validation String Int
type ValAssoc = ValTest -> ValTest -> ValTest -> Bool

main :: IO()
main = do
    --let failure :: String -> Validation String Int
        --failure = Failure
        --success :: Int -> Validation String Int
        --success = Success
        --print $ success 1 <> failure "blah"
        --print $ failure "woot" <> failure "blah"
        --print $ success 1 <> success 2
        --print $ failure "woot" <> success 2
    quickCheck (semigroupAssoc :: ValAssoc)
-}

{-

-- Monoid exercises

-- 1. 

data Trivial = Trivial deriving (Eq, Show)

instance Semigroup Trivial where
    (<>) Trivial _ = Trivial

instance Monoid Trivial where
    mempty = Trivial
    mappend = (<>)

instance Arbitrary Trivial where
    arbitrary = return Trivial

semigroupAssoc :: (Eq m, Semigroup m)
               => m -> m -> m -> Bool
semigroupAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)

type TrivAssoc = 
    Trivial -> Trivial -> Trivial -> Bool

main :: IO ()
main = do
  let sa = semigroupAssoc
      mli = monoidLeftIdentity
      mlr = monoidRightIdentity
  quickCheck (sa :: TrivAssoc)
  quickCheck (mli :: Trivial -> Bool)
  quickCheck (mlr :: Trivial -> Bool)

-}

{-
-- 2.
newtype Identity a = Identity a deriving (Eq, Show)

instance Semigroup a => Semigroup (Identity a) where
    (<>) (Identity x) (Identity y) = Identity (x <> y) 

instance Monoid a => Monoid (Identity a) where
    mempty = Identity mempty
    mappend = (<>)

genId :: Arbitrary a => Gen (Identity a)
genId = do
    a <- arbitrary
    return (Identity a)
instance Arbitrary a => Arbitrary (Identity a) where
    arbitrary = genId


semigroupAssoc :: (Eq m, Semigroup m)
               => m -> m -> m -> Bool
semigroupAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)


type IdType = Identity String
type IdAssoc =
    IdType -> IdType -> IdType -> Bool

main :: IO ()
main = do
  let sa = semigroupAssoc
      mli = monoidLeftIdentity
      mlr = monoidRightIdentity
  quickCheck (sa :: IdAssoc)
  quickCheck (mli :: IdType -> Bool)
  quickCheck (mlr :: IdType -> Bool)

-}

{-
-- 3.

data Two a b = Two a b deriving (Eq, Show)

instance (Semigroup a, Semigroup b) => Semigroup (Two a b) where
    (<>) (Two x y) (Two x' y') = Two (x <> x') (y <> y') 

instance (Monoid a, Monoid b) => Monoid (Two a b) where
    mempty = Two mempty mempty


genTwo :: (Arbitrary a, Arbitrary b) => Gen (Two a b)
genTwo = do
    a <- arbitrary
    b <- arbitrary
    return (Two a b) 

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
    arbitrary = genTwo

semigroupAssoc :: (Eq m, Semigroup m)
               => m -> m -> m -> Bool
semigroupAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)

type GenTwoType = Two String String
type GenTwoAssoc =
    GenTwoType -> GenTwoType -> GenTwoType -> Bool

main :: IO ()
main = do
  let sa = semigroupAssoc
      mli = monoidLeftIdentity
      mlr = monoidRightIdentity
  quickCheck (sa :: GenTwoAssoc)
  quickCheck (mli :: GenTwoType -> Bool)
  quickCheck (mlr :: GenTwoType -> Bool)
-}

{-
-- 4.

newtype BoolConj = 
    BoolConj Bool 
    deriving (Eq, Show)

instance Semigroup BoolConj where
    (<>) (BoolConj True) (BoolConj True) = BoolConj True
    (<>) _ _ = BoolConj False

instance Monoid BoolConj where
    mempty = BoolConj True

instance Arbitrary BoolConj where
    arbitrary = do
    a <- arbitrary
    return (BoolConj a)

semigroupAssoc :: (Eq m, Semigroup m)
               => m -> m -> m -> Bool
semigroupAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)

type GenBoolConjAssoc =
    BoolConj -> BoolConj -> BoolConj -> Bool


main :: IO ()
main = do
  let sa = semigroupAssoc
      mli = monoidLeftIdentity
      mlr = monoidRightIdentity
  quickCheck (sa :: GenBoolConjAssoc)
  quickCheck (mli :: BoolConj -> Bool)
  quickCheck (mlr :: BoolConj -> Bool)
-}

{-
-- 5.

newtype BoolDisj = 
    BoolDisj Bool 
    deriving (Eq, Show)

instance Semigroup BoolDisj where
    (<>) (BoolDisj False) (BoolDisj False) = BoolDisj False
    (<>) _ _ = BoolDisj True

instance Monoid BoolDisj where
    mempty = BoolDisj False

instance Arbitrary BoolDisj where
    arbitrary = do
        a <- arbitrary
        return (BoolDisj a)

semigroupAssoc :: (Eq m, Semigroup m)
               => m -> m -> m -> Bool
semigroupAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)

type GenBoolDisjAssoc =
    BoolDisj -> BoolDisj -> BoolDisj -> Bool

main :: IO ()
main = do
  let sa = semigroupAssoc
      mli = monoidLeftIdentity
      mlr = monoidRightIdentity
  quickCheck (sa :: GenBoolDisjAssoc)
  quickCheck (mli :: BoolDisj -> Bool)
  quickCheck (mlr :: BoolDisj -> Bool)
-}
{-
-- 6.
newtype Combine a b =
    Combine { unCombine :: (a -> b) }

instance  Semigroup b => Semigroup (Combine a b) where
    (Combine { unCombine = f}) <> (Combine { unCombine = g}) = Combine $ \n -> f n <> g n

instance Monoid b => Monoid (Combine a b) where
    mempty = Combine $ const mempty

instance (CoArbitrary a, Arbitrary b) => Arbitrary (Combine a b) where
    arbitrary = do
        h <- arbitrary
        return $ Combine h 

semigroupAssoc :: (Eq m, Semigroup m)
               => m -> m -> m -> Bool
semigroupAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)

-- Can't seem to quickCheck the functions
-}

{-
-- 7.
newtype Comp a = 
    Comp { unComp :: (a -> a)}
    --deriving (Eq, Show a)

instance Semigroup a => Semigroup (Comp a) where
    (Comp {unComp = f1}) <> (Comp {unComp = f2}) = Comp $ f1 . f2

instance Monoid (Comp a) where
    mempty = Comp id

instance Arbitrary a => Arbitrary (Comp a) where
    arbitrary = do
        g <- arbitrary
        return (Comp g)

semigroupAssoc :: (Eq m, Semigroup m)
               => m -> m -> m -> Bool
semigroupAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)

type CompType = Comp (String -> Bool)
type CompAssoc =
    CompType -> CompType -> CompType -> Bool

main :: IO()
main = 
    quickCheck (semigroupAssoc :: CompAssoc)

-- Also can't quickCheck the function
-}

-- 8.

newtype Mem s a =
    Mem {
        runMem :: s -> (a,s)
    }

instance Semigroup a => Semigroup (Mem s a) where
    m1@(Mem f1) <> m2@(Mem f2) =
        Mem $ \s -> (fst (f1 s) <> fst (f2 s),
                     snd (f2 $ snd (f1 s)))

instance Monoid a => Monoid (Mem s a) where
    mempty = Mem $ \x -> (mempty, x)

type MemTest = Mem Int String

