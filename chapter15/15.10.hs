module Optional where

import Data.Monoid

data Optional a =
    Nada
  | Only a
    deriving (Eq, Show)

-- Haskell changed: Monoid's require a Semigroup instance too.
instance Semigroup a => Semigroup (Optional a) where
   (<>) Nada y = y
   (<>) x Nada = x
   (<>) (Only x) (Only y) = Only (x <> y)

instance Monoid a => Monoid (Optional a) where
    mempty = Nada
 