import Data.Monoid
import MonoidSpec (monoidAssoc, monoidLeftIdentity, monoidRightIdentity)
import Option
import Test.QuickCheck

newtype First' a =
  First' { getFirst' :: Optional a }
  deriving (Eq, Show)

instance Semigroup (First' a) where
  (First' Nada) <> y = y
  x             <> _ = x

instance Monoid (First' a) where
    mempty = First' Nada

genOptional :: Arbitrary a => Gen (Optional a)
genOptional = do
    a <- arbitrary
    elements [Nada, Only a]

genFirst' :: Arbitrary a => Gen (First' a)
genFirst' = do
    a <- genOptional
    return (First' a)

instance Arbitrary a => Arbitrary (Optional a) where
    arbitrary = frequency [ (1, return Nada)
                           ,(10, Only <$> arbitrary)]

instance Arbitrary a => Arbitrary (First' a) where
    arbitrary = genFirst'

firstMappend :: First' a
             -> First' a
             -> First' a
firstMappend = mappend

type FirstMappend =
     First' String
  -> First' String
  -> First' String
  -> Bool

type FstId =
  First' String -> Bool

main :: IO ()
main = do
  quickCheck (monoidAssoc :: FirstMappend)
  quickCheck (monoidLeftIdentity :: FstId)
  quickCheck (monoidRightIdentity :: FstId)

