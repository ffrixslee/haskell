-- Exercise: Optional Monoid
import Data.Monoid

data Optional a = 
    Nada
  | Only a
  deriving (Eq, Show)

instance Semigroup a 
      => Semigroup (Optional a) where
    (<>) Nada _ = Nada
    (<>) _ Nada = Nada
    (<>) (Only x) (Only y) = Only (x <> y) 

instance Monoid a => Monoid (Optional a) where
    mempty = Nada