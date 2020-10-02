module FoldBool where
import Data.Bool
foldBool = map (\x -> bool x (-3) (x==3)) [1..10]
