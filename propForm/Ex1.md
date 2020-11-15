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

# Exercise 10(pending)



