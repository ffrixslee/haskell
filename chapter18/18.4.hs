import Control.Monad (ap)

data Sum a b =  
    First a  
  | Second b  
  deriving (Eq, Show)  

type First a = Int
type Second b = Int


instance Functor (Sum a) where  
  fmap _ (First a) = First a
  fmap f (Second b) = Second $ f b

instance Applicative (Sum a) where
  pure = Second
  (<*>) = ap
  (First a) <*> _ = First a
  _ <*> (First a) = First a
  (Second f) <*> (Second b) = Second $ f b

instance Monad (Sum a) where
  return = pure
  (First a) >>= _ = First a
  (Second b) >>= f = f b

  