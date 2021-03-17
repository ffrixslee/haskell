module Main where

import           Criterion.Main
import qualified Data.Vector         as V
import qualified Data.Vector.Unboxed as U

--Exercises: Vector
{-
Set up a benchmark harness with criterion to profile how much
memory boxed and unboxed vectors containing the same
data use. You can combine this with a benchmark to give it
something to do for a few seconds. We’re not giving you a lot
to go on here, because you’re going to have to learn to read
documentation and source code, anyway.
-}

v :: V.Vector Int
v = V.fromList [1..1000]

u :: U.Vector Int
u = U.fromList [1..1000]

main :: IO ()
main = defaultMain
  [ bench "slicing boxed" $
    whnf (V.head . V.slice 100 900) v
  , bench "slicing unboxed" $
    whnf (U.head . U.slice 100 900) u
  ]