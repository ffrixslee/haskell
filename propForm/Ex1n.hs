{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}
{-# OPTIONS_GHC -Wall  #-}

import Data.List
--import Data.Foldable

data Form =
      C Bool  
    | V String
    | Not Form
    | Form `And` Form
    | Form `Or` Form
    deriving (Eq, Ord, Show, Read)

-- First stage:
removeConst :: Form -> Form -- eliminates constants

-- Not case:
removeConst (Not (C False)) = C True
removeConst (Not (C True)) = C False

-- Or case:

removeConst (f `Or` (C True)) = C True
removeConst ((C True) `Or` f) = C True
removeConst (f `Or` (C False)) = f
removeConst ((C False) `Or` f) = f

-- And case: 
removeConst (f `And` (C True)) = f 
removeConst ((C True) `And` f) = f
removeConst (f `And` (C False)) = C False
removeConst ((C False) `And` f) = C False

-- Catch-all clause:
removeConst f = f

-- Second stage: 
simplifyConst :: Form -> Form

-- And clause:
simplifyConst (f1 `And` f2) = removeConst ((simplifyConst f1) `And` (simplifyConst f2))

-- Or clause:
simplifyConst (f1 `Or` f2) = removeConst ((simplifyConst f1) `Or` (simplifyConst f2))

-- Base case:
simplifyConst (Not f) = removeConst (Not f)
simplifyConst f = removeConst f

-- Negation normal form (nnf):

nnf :: Form -> Form

-- And clause:
nnf (Not (f1 `And` f2)) = nnf (Not f1) `Or` nnf (Not f2)

-- Or clause:
nnf (Not (f1 `Or` f2)) = nnf (Not f1) `And` nnf (Not f2)

-- Base case:
nnf (Not (Not f)) = nnf f
nnf f = f

-- Conjunctive normal form (cnf):
distribOr :: Form -> Form -> Form

--  p ∨ (q ∧ r) ≡ (p ∨ q) ∧ (p ∨ r)
distribOr p (q `And` r) = (distribOr p q) `And` (distribOr p r)


-- (q ∧ r) ∨ p ≡ (q ∨ p) ∧ (r ∨ p)
distribOr (q `And` r) p = (distribOr p q) `And` (distribOr p r)

-- third clause if neither the first nor the second argument of distribOr are a conjunction (an And) 
distribOr f1 f2 = f1 `Or` f2

cnf :: Form -> Form
cnf (f1 `Or` f2) = distribOr (cnf f1) (cnf f2)
-- And case:
cnf (f1 `And` f2) = (cnf f1) `And` (cnf f2)

fvList :: Form -> [String]
-- *: nub is not required as there is another function called `union`

-- Using nub:
--test: fvList ( V x1 ) = nub $ ((++) [x1, "hi"] ["a"])
--fvList (V x1 `And` (Not (V x2)))  = nub $ ((++) [x1] [x2])
--fvList (V x1 `Or` (Not (V x2)))  = nub $ ((++) [x1] [x2])

--Using `union`:
-- C bool clause:
fvList (C _) = []
-- V String clause:
fvList (V y) = [y]
-- Not clause:
fvList (Not z) = fvList z
-- And clause:
fvList (f1 `And` f2) = (fvList f1) `union` (fvList f2)
-- Or clause:
fvList (f1 `Or` f2) = (fvList f1) `union` (fvList f2)

-- Replace a variable by a constant (Substitution)

{-
subst :: Form -> (String, Bool) -> Form
subst (V x1) (x3, x4) = 
    case (V x1)  of
      (V x1)
          | (x1 == x3) -> C x4
          | (x1 /= x3) -> V x1
-}

--Alternatively using guards:
subst :: Form -> (String, Bool) -> Form
subst (V x1) (x2, b) 
          | (x1 == x2) = C b
          | (x1 /= x2) = V x1

-- Substitution all (substAll)
substAll :: Form -> [(String, Bool)] -> Form
substAll = foldl subst

-- Evaluation of a formula (evalSubst)
evalSubst :: Form -> [(String, Bool)] -> Bool
evalSubst (V x1) v = getBooley $ simplifyConst $ substAll (V x1) v

getBooley x = 
    case x of
     C x -> x
     otherwise -> error "non-constant value"

-- Model finding
models :: Form -> [(String, Bool)] -> [String] -> [[(String, Bool)]]
models f vl [] 
    | evalSubst f vl == True = [vl]
    | otherwise = []

-- if there are still variables to be processed
models f vl (vn : vns) = (models f ((vn, True):vl) vns)
models f vl (vn : vns) = (models f ((vn, False):vl) vns)

models f vl (vn : vns) =  (models f ((vn, True):vl) vns) ++ (models f ((vn, False):vl) vns)

allModels :: Form -> [[(String, Bool)]]
allModels f  = models f [] (fvList f)

unsatisfiable :: Form -> Bool
unsatisfiable f = null (allModels f)

valid :: Form -> Bool
valid x1 = unsatisfiable $ (Not x1)

-- Start of second exercise
--Rl :- x, xs
--Gl ?- xs
--Prog :- x, xs

{-
test :: Prog
test 
  = Pr
    [Rl "x" [xs]
    ]
    (Gl [xs])
-}


-- Exercise 15
data Rule = Rl String [String]
data Goal = Gl [String]
data Prog = Pr [Rule] Goal  

mortalSocrates :: Prog
mortalSocrates
    = Pr
    [
    Rl "m" ["h"]
    ]
    (Gl ["m"])

abcdProg :: Prog
abcdProg
  = Pr
  [Rl "a" [],
  Rl "d" ["b", "c"],
  Rl "d" ["a", "c"],
  Rl "c" ["a"]
  ]
  (Gl ["d", "c"])


