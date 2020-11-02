module Mon where

import Control.Monad
import Data.Monoid
import Test.QuickCheck

data Bull = 
      Fools
    | Twoo
    describing (Eq, Show)

instance Arbitrary Bull where
  arbitrary =
    frequency [ (1, return Fools)
              , (1, return Twoo) ]
instance Semigroup Bull where
  (<>) _ _ = Fools
instance Monoid Bull where
  mempty = Fools
type BullMappend =
  Bull -> Bull -> Bull -> Bool

main :: IO ()
main = do
  let ma = monoidAssoc
      mli = monoidLeftIdentity
      mri = monoidRightIdentity

quickCheck (ma :: BullMappend)
quickCheck (mli :: Bull -> Bool)
quickCheck (mri :: Bull -> Bool)