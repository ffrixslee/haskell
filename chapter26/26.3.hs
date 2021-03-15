newtype EitherT e m a =
    EitherT { runEitherT :: m (Either e a) }

-- Exercises: Either T
-- 1.

instance Functor m
      => Functor (EitherT e m) where
    fmap f (EitherT em) = EitherT $ (fmap . fmap) f em 

-- 2.
instance Applicative m
      => Applicative (EitherT e m) where
    pure x = EitherT (pure (pure x))
    EitherT f <*> EitherT em = EitherT $ (<*>) <$> f <*> em

-- 3.
instance Monad m 
      => Monad (EitherT e m) where
    return = pure

    EitherT m >>= f = EitherT $ do
    v <- m
    case v of
        Left x -> return (Left x)
        Right y -> runEitherT $ f y

-- 4. 
swapEither :: Either a b -> Either b a
swapEither (Left a) = Right a
swapEither (Right b) = Left b

swapEitherT :: (Functor m) => EitherT e m a -> EitherT a m e
swapEitherT (EitherT ema) = EitherT $ fmap swapEither ema

-- 5.
eitherT :: Monad m =>
           (a -> m c)
        -> (b -> m c)
        -> Either a m b
        -> m c
eitherT fa fb (EitherT amb) = amb >>= f
  where f (Left a) = fa a 
        f (Right b) = fb b