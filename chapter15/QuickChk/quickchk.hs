-- stack --resolver lts-12.18 script --package QuickCheck

module QuickChk where
import Data.Monoid


monoidAssoc :: (Eq m, Monoid m)
            => m -> m -> m -> Bool

monoidAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)