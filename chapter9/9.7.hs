{-
mySqr = [x^2 | x <- [1..10]]
--myEvenSqr = [x | x <- mySqr, rem x 2 == 0]
--mySqrXY = [(x, y) | x <- mySqr, y <- mySqr,x < 50, y > 50]
myTakeFive = take 5 [ (x, y) | x <- mySqr, y <- mySqr, x <                    50, y > 50 ]
-}

 mySqr = [x^2 | x <- [1..5]]
 myCube = [y^3 | y <- [1..5]]

 mySqrCube = length[(x,y) | x <- mySqr, y <- myCube, x < 50, y < 50]