{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}
{-# OPTIONS_GHC -Wall  #-}

import Data.List

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
--removeConst ((C False) `Or` (C True)) = f
--removeConst ((C True) `Or` f) = f
removeConst (f `Or` (C True)) = C True
removeConst ((C True) `Or` f) = C True
removeConst (f `Or` (C False)) = f
removeConst ((C False) `Or` f) = f

--removeConst (f `Or` (Not (C True))) = f
--removeConst ((Not (C True)) `Or` (Not f)) = Not f

-- And case: 
removeConst (f `And` (C True)) = f 
removeConst ((C True) `And` f) = f
removeConst (f `And` (C False)) = C False
removeConst ((C False) `And` f) = C False
--removeConst ((Not (C False)) `And` f) = f
--removeConst ((Not (C True)) `And` (Not f)) = Not f

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
distribOr p (q `And` r) = (distribOr p (p `Or` q)) `And` (distribOr p (p `Or` r))


-- (q ∧ r) ∨ p ≡ (q ∨ p) ∧ (r ∨ p)
distribOr (q `And` r) p = (distribOr p (q `Or` p) ) `And` (distribOr p (r `Or` p) )


-- third clause if neither the first nor the second argument of distribOr are a conjunction (an And) 
distribOr f1 f2 = f1 `Or` f2

cnf :: Form -> Form
cnf ((p `And` q) `Or ` (r `And` s))  = (distribOr (p `And` q ) r) `And` (distribOr (p `And` q) s ) 


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


-- Evaluation of a formula (evalSubst)
evalSubst :: Form -> [(String, Bool)] -> Bool
evalSubst (V x1) v = getBooley $ simplifyConst $ substAll (V x1) v

getBooley x = 
    case x of
     C x -> x
     otherwise -> error "non-constant value"


{-
evalSubst (V x1) [(x2, b)] = go (V x1) [(x2, b)]
    where go (V x1) [(x2, b)]
           | (x1 == x2) = True
           | (x1 /= x2) = False
           | otherwise = go $ simplifyConst $ substAll (V x1) [(x2, b)]
-}


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
prog :: pr
prog =
    pr
    [ rl "x" [xs]
    ]
    (gl [xs])
-}


-- Exercise 15
data Rule = Rl Form [Form]
data Goal = Gl [Form]
data Prog = Pr Form [Form] 

-- Exercise 16 (pending)
ruleToForm :: Rule -> Form
ruleToForm (Rl x [xs]) = x 

goalToForm :: Goal -> Form
goalToForm (Gl [xs]) = xs

progToForm :: Prog -> Form
progToForm (Pr a b) = a


implies :: Form -> Form -> Form
implies x y = (Not x) `Or` y  

-- Pending:
{-
conj :: [Form] -> Form

--conj f z = foldl f z []
--conj = foldl (\f -> if null f then [] else f)


conj f = 
    case f of
     [] -> C True
     otherwise -> foldl f z []

-}

-- Exercise 17 (Any and All)
divThreeAny = any (\x -> (x `mod` 3 == 0)) [1, 4, 5, 6]
divThreeAll = all (\x -> (x `mod` 3 == 0)) [1, 4, 5, 6]

-- Exercise 18 (List comprehension)
sqrNeg = [x^2 | x <- [1, -3, 4, -5], x<0 ]

-- Pending:
--ruleHead y  = [y | y <- Rl (Form [Form]), y /= [] ]
-- rules don't have an empty body ie [].
ruleHead prog  = [y | y <- prog, y /= []]
-- Exercise 19
-- Exercise 20 



