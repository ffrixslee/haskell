{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}

import Data.List

data Form = 
    V String
    | Not Form
    | Form `And` Form
    | C Bool 
    | Form `Or` Form
    deriving (Eq, Ord, Show, Read)

-- First stage:

removeConst :: Form -> Form -- eliminates constants

-- Not case:
removeConst (f `And` (Not (C False))) = f
removeConst ((Not (C False)) `And` f) = f

-- Or case:
--removeConst ((C False) `Or` (C True)) = f
--removeConst ((C True) `Or` f) = f
removeConst ((C False) `Or` f) = f
removeConst (f `Or` (C False)) = f

--removeConst (f `Or` (Not (C True))) = f
--removeConst ((Not (C True)) `Or` (Not f)) = Not f

-- And case: 
removeConst (f `And` (C True)) = f
removeConst ((C True) `And` f) = f
removeConst ((C False) `And` f) = f
removeConst (f `And` (C False)) = (C False)
--removeConst ((Not (C False)) `And` f) = f
--removeConst ((Not (C True)) `And` (Not f)) = Not f

-- Catch-all clause:
removeConst f = f

-- Second stage: 
simplifyConst :: Form -> Form

-- Base case:
simplifyConst f = removeConst f

-- And clause:
simplifyConst (f1 `And` f2) = removeConst ((simplifyConst f1) `And` (simplifyConst f2))


-- Or clause:
simplifyConst (f1 `Or` f2) = removeConst ((simplifyConst f1) `Or` (simplifyConst f2))

-- Negation normal form (nnf):

nnf :: Form -> Form

-- Base case:
nnf f = f
nnf (Not (Not f)) = f

-- And clause:
nnf (Not (f1 `And` f2)) = nnf (nnf(Not f1) `Or` nnf(Not f2))

-- Or clause:
nnf (Not (f1 `Or` f2)) = nnf (nnf (Not f1) `And` nnf (Not f2))

-- Pending
-- Conjunctive normal form (cnf):
distribOr :: Form -> Form -> Form
distribOr f1 f2 = f1 `Or` f2

cnf :: Form -> Form
cnf distribOr = (distribOr) `And` (distribOr)


-- Pending (more cases yet to be added)
fvList :: Form -> [String]
--fvList ( V x1 ) = nub $ ((++) [x1, "hi"] ["a"])
fvList (V x1 `And` (Not (V x2)))  = nub $ ((++) [x1] [x2])
fvList (V x1 `Or` (Not (V x2)))  = nub $ ((++) [x1] [x2])

-- Base case:
fvList _ = []

-- Replace a variable by a constant (Substitution)
subst :: Form -> (String, Bool) -> Form
subst (V x1) (x3, x4) = 
    case (V x1)  of
      (V x1)
          | (x1 == x3) -> C x4
          | (x1 /= x3) -> V x1


{-
Alternatively using guards:
subst (V x1) (x3, x4) 
          | (x1 == x3) = C x4
          | (x1 /= x3) = V x1
-}

-- Substitution all (substAll)
substAll :: Form -> [(String, Bool)] -> Form
substAll = foldl subst

{-
-- Evaluation of a formula (evalSubst)
evalSubst :: Form -> [(String, Bool)] -> Bool
evalSubst (V x1) (x3, x4) 
          | (x1 == x3) = True
          | (x1 /= x3) = False
--          | _ = simplifyConst substAll (V x1) (x3, x4) 
-}

-- Model finding
models :: Form -> [(String, Bool)] -> [String] -> [[(String, Bool)]]









