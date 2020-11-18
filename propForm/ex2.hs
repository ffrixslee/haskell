{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

import Data.List

data Form = 
    V String
    | Not Form
    | And Form Form
    | C Bool 
    | Or Form Form
    deriving (Eq, Ord, Show, Read)

-- First stage:

removeConst :: Form -> Form -- eliminates constants
removeConst f1 = go f1 
    where go f1
           | removeConst (And (f1) (C True)) = f1 
           | removeConst (Or  (f1) (C False)) = f1
           | removeConst f1 = f1 

unsatisfiable :: Form -> Bool
unsatisfiable f
        | f [] = False
        | otherwise = True



