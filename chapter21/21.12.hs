module Traversing where

import Data.Monoid
import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

-- :info traverse
-- class (Functor t, Foldable t) => Traversable (t :: * -> *) where
-- traverse :: Applicative f => (a -> f b) -> t a -> f (t b)

newtype Identity a = Identity a
    deriving (Eq, Ord, Show)

instance Traversable Identity where
    traverse f x = x

type TI = []
main = do
  let trigger :: TI (Int, Int, [Int])
      trigger = undefined

quickBatch (traversable trigger)
