-- Exercise: Possibly

incIfJust :: Num a => Maybe a -> Maybe a
incIfJust (Just n) = Just $ n + 1
incIfJust Nothing  = Nothing

showIfJust :: Show a => Maybe a -> Maybe String
showIfJust (Just s) = Just $ show s
showIfJust Nothing  = Nothing

incMaybe :: Num a => Maybe a -> Maybe a
incMaybe = fmap (+1)

showMaybe :: Show a => Maybe a -> Maybe String
showMaybe = fmap show

liftedInc :: (Functor f, Num a) => f a -> f a
liftedInc = fmap (+1)

liftedShow :: (Functor f, Show a) => f a -> f String
liftedShow = fmap show

-- 

data Possibly a =
    LolNope
  | Yeppers a
  deriving (Eq, Show)

instance Functor Possibly where
    fmap _ LolNope = LolNope
    fmap f (Yeppers x) = Yeppers (f x)

possiblyTest :: [Char]
possiblyTest = liftedShow Yeppers [3,4,10]

-- 
incIfRight :: Num a
            => Either e a
            -> Either e a
incIfRight (Right n) = Right $ n + 1
incIfRight (Left e) = Left e
showIfRight :: Show a
            => Either e a
            -> Either e String
showIfRight (Right s) = Right $ show s
showIfRight (Left e) = Left e

incEither :: Num a
            => Either e a
            -> Either e a
incEither m = fmap (+1) m
showEither :: Show a
            => Either e a
            -> Either e String
showEither s = fmap show s

-- eta reduce
incEither' :: Num a
            => Either e a
            -> Either e a
incEither' = fmap (+1)
showEither' :: Show a
            => Either e a
            -> Either e String
showEither' = fmap show

-- 

data Sum a b =
    First a 
  | Second b
  deriving (Eq, Show)

instance Functor (Sum a) where
    fmap _ (First x) = First x
    fmap f (Second y) = Second (f y)

applyIfSecond :: (a -> b) -> (Sum e) a -> (Sum e) b
applyIfSecond f s = fmap f s

-- 2.
-- Answer: A type constructor with more than two type arguments must include all type arguments except the inner-most argument.