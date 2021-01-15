simple x = x
longList = [1..]
stillLongList = simple longList

-- Quick check 6.1
backwardsInfinity = reverse [1..]
-- Result: True

subseq x  xs [aList] = drop x : xs : [aList]