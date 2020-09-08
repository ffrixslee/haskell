{-# LANGUAGE NoMonomorphismRestriction #-}
module DetermineTheType where
-- simple example
example = (length [1, 2, 3, 4]) > (length "TACOCAT") 
-- If you do not include the NoMonomorphismRestriction extension, example would have the type Integer instead of Num a => a.