{-# LANGUAGE InstanceSigs #-}

import Control.Applicative
import Control.Monad(join)
import Data.Char

newtype Reader r a =
    Reader { runReader :: r -> a }

instance Monad (Reader r) where
    pure :: a -> Reader r a
    pure a = Reader (\r -> a)
    return = pure

    (>>=) :: Reader r a
          -> (a -> Reader r b)
          -> Reader r b
    (Reader ra) >>= aRb = 
        join $ Reader $ \r -> aRb (ra r)


