module PropLogic where

-- Datatype definitions

-- In Prolog:
--Rl :- x, xs
--Gl ?- xs
--Prog :- x, xs

prog :: Pr
prog =
    Pr
    [ Rl "x" [xs]
    ]
    (Gl [xs])

implies :: RuleToForm -> GoalToForm -> ProgToForm
implies f1 f2 = (Not f1) `Or` f2  

conj :: [Form] -> Form
conj [] = C True
conj f = foldl f


-- Exercise 17
divThree :: Int -> Bool
divThree x = any  ([1, 4, 5, 6] mod 3 == 0)

divThreeAll = all ([1, 4, 5, 6] mod 3 == 0)


