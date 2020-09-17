-- Ord go hand-in-hand with Eq
data DayOfWeek =
    Mon | Tues | Weds | Thu | Fri | Sat | Sun
    deriving (Ord, Show)


instance Eq DayOfWeek where
(==) Mon Mon = True
(==) Tues Tues = True
(==) Weds Weds = True
(==) Thu Thu = True
(==) Fri Fri = True
(==) Sat Sat = True
(==) Sun Sun = True
(==) _ _ = False
