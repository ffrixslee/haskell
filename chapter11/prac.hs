{- Newtype

class TooMany a where
    tooMany :: a -> Bool

instance TooMany Int where
    tooMany n = n > 42

newtype Goats = Goats Int deriving Show

instance TooMany Goats where
    tooMany (Goats n) = n > 43 
-}

{- Record syntax

data Person = 
    MkPerson String Int
    deriving (Eq, Show)

data Person = 
    Person { name :: String
           , age :: Int }
           deriving (Eq, Show)

jm = MkPerson "julie" 108
ca = MkPerson "chris" 16

namae :: Person -> String
namae (MkPerson s _) = s  
-}

{-
data Fiction = Fiction deriving Show
data Nonfiction = Nonfiction deriving Show

data BookType = FictionBook Fiction
              | NonfictionBook Nonfiction
              deriving Show

type AuthorName = String --type synonym
data Author = Author (AuthorName, BookType) 
-}

