--in REPL: stack GHCI -- package QuickCheck
module MonoidAssoc where
import Data.Monoid

monoidAssoc :: (Eq m, Monoid m)
            => m -> m -> m -> Bool

monoidAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)

{-
REPL output: 
*QuickChk Test.QuickCheck> type S = String
*QuickChk Test.QuickCheck> type B = Bool
*QuickChk Test.QuickCheck> type MA = S -> S -> S -> B
*QuickChk Test.QuickCheck> quickCheck (monoidAssoc :: MA)
+++ OK, passed 100 tests.
-}

monoidLeftIdentity :: (Eq m, Monoid m)
                    => m
                    -> Bool
monoidLeftIdentity a = (mempty <> a) == a

monoidRightIdentity :: (Eq m, Monoid m)
                    => m
                    -> Bool
monoidRightIdentity a = (a <> mempty) == a

{-
REPL output:
*QuickChk Test.QuickCheck> mli = monoidLeftIdentity
*QuickChk Test.QuickCheck> mri = monoidRightIdentity
*QuickChk Test.QuickCheck> quickCheck (mli :: String -> Bool)
+++ OK, passed 100 tests.
*QuickChk Test.QuickCheck> quickCheck (mri :: String -> Bool)
+++ OK, passed 100 tests.
-}