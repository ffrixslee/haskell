{-# LANGUAGE InstanceSigs #-}
import Control.Monad.Trans.Class
import Control.Monad             (liftM)

newtype EitherT e m a = EitherT { runEitherT :: m (Either e a)}

newtype StateT s m a = StateT { runStateT :: s -> m (a, s) }

-- 1.
instance MonadTrans (EitherT e) where
    lift = EitherT . liftM Right

instance MonadTrans (StateT s) where
    lift m = StateT $ \s -> do
        a <- m
        return $ (a, s)