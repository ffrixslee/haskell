eft :: Enum a => a -> a -> [a]
eft from to
    | start > stop = []
    | start == stop = [from]
    | otherwise = from : eft (succ from) to
        where start = fromEnum from
              stop = fromEnum to

eftBool :: Bool -> Bool -> [Bool]
eftBool = eft
eftOrd :: Ordering -> Ordering -> [Ordering]
eftOrd = eft
eftInt :: Int -> Int -> [Int]
eftInt = eft
eftChar :: Char -> Char -> [Char]
eftChar = eft

