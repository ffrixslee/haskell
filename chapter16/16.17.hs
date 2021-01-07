{-# LANGUAGE FlexibleInstances #-}

-- 16.17 Chapter Exercises
import GHC.Arr


-- 1. 
data Bool = 
    False | True

-- No, a valid Functor cannot be written as there is no type argument for the function to be  applied to.
-- Bool is a type with the kind * .

-- 2. 
data BoolAndSomethingElse a =
    False' a | True' a

instance Functor BoolAndSomethingElse where
    fmap f (False' x) = False' (f x)
    fmap f (True'  x) = True' (f x)

-- 3.
data BoolAndMaybeSomethingElse a =
    Falsish | Truish a

instance Functor BoolAndMaybeSomethingElse where
    fmap _ Falsish = Falsish
    fmap f (Truish x) = Truish (f x)

-- 4. 
newtype Mu f = InF { outF :: f (Mu f) }

-- Mu has kind (* -> *) -> * so may need to be wrapped due to its higher-kindedness.

-- 5.

data D = 
    D (Array Word Word) Int Int

-- No, a valid Functor cannot be written as data D has kind * and not (* -> *).

-- Rearrange the arguments to the type constructor of the datatype so the Functor instance works:

-- 1. 
data Sum b a = 
    First a
  | Second b

instance Functor (Sum e) where
    fmap f (First a) = First (f a)
    fmap f (Second b) = Second b

-- 2. 
data Company a c b = 
    DeepBlue a c
  | Something b

instance Functor (Company e e') where
    fmap f (Something b) = Something (f b)
    fmap _ (DeepBlue a c) = DeepBlue a c

-- 3. 
data More b a =
    L a b a
  | R b a b
  deriving (Eq, Show)

instance Functor (More x) where
    fmap f (L a b a') = L (f a) b (f a')
    fmap f (R b a b') = R b (f a) b'

-- Write Functor instances for the following datatypes:

-- 1. 
data Quant a b =
    Finance
  | Desk a
  | Bloor b

instance Functor (Quant a) where
    fmap _ Finance = Finance
    fmap _ (Desk x) = Desk x
    fmap f (Bloor y) = Bloor (f y) 

-- 2.
data K a b =
    K a

instance Functor (K a) where
    fmap _ (K a) = K a

-- 3. 
newtype Flip f a b = 
    Flip (f b a)
    deriving (Eq, Show)

instance Functor (Flip K a) where
    fmap f (Flip (K a)) = Flip $ K (f a)

-- 4.
data EvilGoateeConst a b =
    GoatyConst b

instance Functor (EvilGoateeConst a) where
    fmap f (GoatyConst x) = GoatyConst (f x)

-- 5.
data LiftItOut f a =
    LiftItOut (f a)

instance Functor f => Functor (LiftItOut f) where
    fmap f (LiftItOut fa) = LiftItOut (fmap f fa)

-- 6.
data Parappa f g a = 
    DaWrappa (f a) (g a)

instance (Functor f, Functor f1) => Functor (Parappa f f1) where
    fmap f (DaWrappa fa ga) = DaWrappa (fmap f fa) (fmap f ga) 

-- 7.
data IgnoreOne f g a b = 
    IgnoringSomething (f a) (g b)

instance Functor g => Functor (IgnoreOne f g a) where
    fmap f (IgnoringSomething fa gb) = IgnoringSomething fa (fmap f gb)

-- 8. 
data Notorious g o a t =
    Notorious (g o)(g a)(g t)

instance Functor f => Functor (Notorious f a b) where
    fmap f (Notorious fx fy fz) = Notorious fx fy (fmap f fz)

-- 9.
data List a = 
    Nil
  | Cons a (List a)

instance Functor List where
    fmap _ Nil = Nil
    fmap f (Cons x lx) = Cons (f x) (fmap f lx)

-- 10.
data GoatLord a = 
    NoGoat
  | OneGoat a
  | MoreGoats (GoatLord a)
              (GoatLord a)
              (GoatLord a)

instance Functor GoatLord where
    fmap _ NoGoat = NoGoat
    fmap f (OneGoat x) = OneGoat (f x)
    fmap f (MoreGoats x y z) = MoreGoats (fmap f x) (fmap f y) (fmap f z)

-- 11.
data TalkToMe a =
    Halt
  | Print String a
  | Read (String -> a)

instance Functor TalkToMe where
    fmap _ Halt = Halt
    fmap f (Print x y) = Print x (f y)
    fmap f (Read f2a) = Read (fmap f f2a)