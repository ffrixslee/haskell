
newtype Reader r a =
    Reader { runReader :: r -> a }
{-
instance Functor (Reader r) where
    fmap :: (a -> b)
         -> Reader r a
         -> Reader r b

    fmap f (Reader ra) = 
        Reader $ (f . ra)
-}

ask :: Reader a a 
ask = Reader id

{- 
What do you know about the type a ?
- type a is of the function type a -> a being applied to a value of type a
What does the type simplify to?
- the type simplifies to a
How many inhabitants does that type have?
- only 1
-}