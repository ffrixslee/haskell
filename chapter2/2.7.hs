-- learn.hs
module Learn where
  x = 10 * 5 + y

  myResult = x * 5

  y = 10

  -- practice.hs
module Mult1 where
mult1 = x * 3 + y
  where x = 3
        y = 1000

-- practice.hs
module Mult2 where
mult2 = x * 5
  where y = 10
        x = 10 * 5 + y
module Mult3 where
mult3 = z / x + y
  where x = 7
        y = negate x
        z = y * 10
