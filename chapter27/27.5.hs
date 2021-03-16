-- Exercises: Evaluate

-- 1.
ex1 = const 1 undefined

-- 2.
ex2 = const undefined 1

-- 3. 
ex3 = flip const undefined 1

-- 4. 
ex4 = flip const 1 undefined

-- 5. 
ex5 = const undefined undefined

--6. 
ex6 = foldr const 'z' ['a'..'e']

--7.
ex7 = foldr (flip const) 'z' ['a'..'e']