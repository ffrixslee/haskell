module Arith4 where
    
roundTrip' :: (Show a, Read b) => a -> b
roundTrip' = read . show

