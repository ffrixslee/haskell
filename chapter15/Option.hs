-- Haskell changed: Monoid's require a Semigroup instance too.
module Option where
import Data.Monoid

data Optional a =
    Nada
    | Only a
    deriving (Eq, Show)

instance Semigroup a => Semigroup (Optional a) where
    (<>) Nada _ = Nada --base case  
    (<>) _ Nada = Nada -- base case
    (<>) (Only x) (Only y) = Only (x<>y) -- most important

instance Monoid a
      => Monoid (Optional a) where
    mempty = Nada
 