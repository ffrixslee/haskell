--3.1 
--(\x -> x*2) 5
-- Prelude> (\x -> x*2) 2

--sumSquareOrSquareSum x y = if sumSquare > squareSum
--                            then sumSquare
--                            else squareSum
--    where sumSquare = x^2 + y^2
--          squareSum = (x+y)^2

doubleDouble x = (\dubs -> dubs * 2) x*2


