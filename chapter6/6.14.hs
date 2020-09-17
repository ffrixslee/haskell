import Prelude
import Data.List

arith :: Num b => (a -> b) -> Integer -> a -> b
arith f x y = fromInteger x * f y