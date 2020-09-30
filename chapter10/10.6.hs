import Data.Time
data DatabaseItem = DbString String
                  | DbNumber Integer
                  | DbDate UTCTime
                  deriving (Eq, Ord, Show)
theDatabase :: [DatabaseItem]
theDatabase =
 [ DbDate (UTCTime
        (fromGregorian 1911 5 1)
    (secondsToDiffTime 34123)), DbNumber 9001, DbString "Hello, world!", DbDate (UTCTime (fromGregorian 1921 5 1)(secondsToDiffTime 34123))
 ]

filterDbNumber :: [DatabaseItem] -> [Integer]
filterDbNumber xs = foldr f [] xs
    where f (DbNumber n) ns = n : ns
          f _          ns = ns

sumDb :: [DatabaseItem] -> Integer
sumDb = sum . filterDbNumber

