{-
-- FunctionWithWhere.hs
module FunctionWithWhere where

  printInc n = print plusTwo
    where plusTwo = n + 2

{- Let: Introduces an expression
  Where: Is a declaration and is bound to a surrounding syntactic construct -}

-- FunctionWithLet.hs
module FunctionWithLet where

  printInc2 n = let plusTwo = n + 2
                in print plusTwo -}

-- practice.hs
{- module Mult1 where

mult1     = x * y
  where x = 5
        y = 6 -}

{- module Mult2 where

mult2 = x * 3 + y
  where x = 3
        y = 1000 -}

 {- module Mult3 where

mult3 = x * 5
  where y =10
        x = 10 * 5 + y -}

module Mult4 where

mult4 = z / x + y
  where x = 7
        y = negate x
        z = y * 10
        
