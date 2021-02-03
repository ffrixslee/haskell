{-# LANGUAGE InstanceSigs #-}

-- 1.

myLiftA2 :: Applicative f =>
            (a -> b -> c)
         -> f a -> f b -> f c

(<$->>) :: (a -> b)
        -> (r -> a)
        -> (r -> b)
(<$->>) = (<$>)

(<*->>) :: (r -> a -> b)
        -> (r -> a)
        -> (r -> b)
(<*->>) = (<*>)

--myLiftA2 f x y = f <$->> x <*->> y

myLiftA2 f x y = f <$> x <*> y

-- 2.
newtype Reader r a =
    Reader { runReader :: r -> a }

asks :: (r -> a) -> Reader r a
asks f = Reader f

-- 3.
instance Functor (Reader r) where
    fmap f (Reader x) = 
        Reader $ f . x


instance Applicative (Reader r) where
    pure :: a -> Reader r a
    pure a = Reader (\r -> a)

    (Reader rab) <*> (Reader ra) =
        Reader $ (\r -> (rab <*> ra) r)
{-
    (<*>) :: Reader r (a -> b)
          -> Reader r a
          -> Reader r b
-}