# Exercise 1 

```hs
data Form = 
    V String
    | Not Form
    | Form `And` Form
    | C Bool 
    | Form `Or` Form
    deriving (Eq, Ord, Show, Read)
```

# Exercise 2
- Why can’t we write True `And` False but have to write (C True) `And` (C False)?  
> Because True and False are already `Bool` datatypes and therefore must be assigned to a constant.  

- Why can’t we write r `And` (Not r) but have to write V "r" `And` (Not (V "r"))?  
> Because then variable r is not in scope.

# Exercise 3
```hs
removeConst :: Form -> Form -- eliminates constants

-- Not case:
removeConst (f `And` (Not (C False))) = f
removeConst ((Not (C False)) `And` f) = f

-- Or case:
removeConst (f `Or` (C True)) = f
removeConst ((C True) `Or` f) = f
removeConst ((C False) `Or` f) = f
removeConst (f `Or` (C False)) = f
--removeConst (f `Or` (Not (C True))) = f
--removeConst ((Not (C True)) `Or` (Not f)) = Not f

-- And case: 
removeConst (f `And` (C True)) = f
removeConst ((C True) `And` f) = f
removeConst ((C False) `And` f) = (C False)
removeConst (f `And` (C False)) = (C False)
--removeConst ((Not (C False)) `And` f) = f
--removeConst ((Not (C True)) `And` (Not f)) = Not f

-- Catch-all clause:
removeConst f = f
```
> If you put it as the first clause then it will always return f regardless of the different cases.  

# Exercise 4
```hs
-- Second stage: 
simplifyConst :: Form -> Form

-- And clause:
simplifyConst (f1 `And` f2) = removeConst ((simplifyConst f1) `And` (simplifyConst f2))


-- Or clause:
simplifyConst (f1 `Or` f2) = removeConst ((simplifyConst f1) `Or` (simplifyConst f2))

-- Base case:
simplifyConst f = removeConst f
```

# Exercise 5
```hs
-- Negation normal form (nnf):

nnf :: Form -> Form

-- Base case:
nnf f = f
nnf (Not (Not f)) = f

-- And clause:
nnf (Not (f1 `And` f2)) = nnf (nnf(Not f1) `Or` nnf(Not f2))

-- Or clause:
nnf (Not (f1 `Or` f2)) = nnf (nnf (Not f1) `And` nnf (Not f2))
```

# Exercise 6 (pending)

CNF 

# Exercise 7 (pending)
```hs
-- Pending
fvList :: Form -> [String]
--fvList ( V x1 ) = nub $ ((++) [x1, "hi"] ["a"])
fvList (V x1 `And` (Not (V x2)))  = nub $ ((++) [x1] [x2])
fvList (V x1 `Or` (Not (V x2)))  = nub $ ((++) [x1] [x2])

-- Base case:
fvList _ = []
```

# Exercise 8
```hs
subst (V x1) (x3, x4) = 
    case (V x1)  of
      (V x1)
          | (x1 == x3) -> C x4
          | (x1 /= x3) -> V x1
```

# Exercise 9 
```hs
substAll :: Form -> [(String, Bool)] -> Form
substAll = foldl subst
```

# Exercise 10
```hs
-- Evaluation of a formula (evalSubst)
evalSubst :: Form -> [(String, Bool)] -> Bool
evalSubst (V x1) v = getBooley $ simplifyConst $ substAll (V x1) v

getBooley x = 
    case x  of
      x
        | (x == C True) -> True
        | (x == C False) -> False


{-
evalSubst (V x1) [(x2, b)] = go (V x1) [(x2, b)]
    where go (V x1) [(x2, b)]
           | (x1 == x2) = True
           | (x1 /= x2) = False
           | otherwise = go $ simplifyConst $ substAll (V x1) [(x2, b)]
-}
```

# Exercise 11
```hs
-- Model finding
models :: Form -> [(String, Bool)] -> [String] -> [[(String, Bool)]]
models f vl [] 
    | evalSubst f vl == True = [vl]
    | otherwise = []

-- if there are still variables to be processed
models f vl (vn : vns) = (models f ((vn, True):vl) vns)
models f vl (vn : vns) = (models f ((vn, False):vl) vns)

models f vl (vn : vns) =  (models f ((vn, True):vl) vns) ++ (models f ((vn, False):vl) vns)
```

# Exercise 12
```hs
allModels :: Form -> [[(String, Bool)]]
allModels f  = models f [] (fvList f)
```

# Exercise 13
```hs
unsatisfiable :: Form -> Bool
unsatisfiable f = null (allModels f)
```

# Exercise 14
```hs
valid :: Form -> Bool
valid x1 = unsatisfiable $ (Not x1)
```
--- 

# Exercise 15
```hs
data Rule = Rl String [String]
data Goal = Gl [String]
data Prog = Pr String [String] 
```
# Exercise 16
subforms :: Form -> [Form]
subforms (P n) = [(P n)]
subforms (Conj f1 f2) = (Conj f1 f2):(subforms f1 ++ subforms f2)
subforms (Disj f1 f2) = (Disj f1 f2):(subforms f1 ++ subforms f2)
subforms (Neg f) = (Neg f):(subforms f)

This gives, e.g.:
IAR> subforms (Neg (Disj (P 1) (Neg (P 2))))
[~(P1 v ~P2),(P1 v ~P2),P1,~P2,P2]
# Exercise 17
```hs 
divThreeAny = any (\x -> (x `mod` 3 == 0)) [1, 4, 5, 6]
divThreeAll = all (\x -> (x `mod` 3 == 0)) [1, 4, 5, 6]
```



