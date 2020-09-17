mySqr = [x^2 | x <- [1..10]]

[(x, y) | x <- mySqr,
y <- mySqr,
x < 50, y > 50]

