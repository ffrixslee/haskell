-- Exercises: Comprehension check

-- 1) 
half x = x / 2
halfhalf x = half x / (x / 2)

square x = x * x 
squareroot x = sqrt (square x)

-- 2)
triple x = x * 3
{- Output:
  *Main> half x = x /2
  *Main> half 2
  1.0
  *Main> half 2.4
  1.2
  *Main> square x = x * x
  *Main> square 3
  9
-}

-- 2)
squarepie p = 3.14 * (p * p)

-- 3)
square2 p = pi * (p * p)
