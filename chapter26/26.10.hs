{-# LANGUAGE InstanceSigs #-}

import Control.Monad.IO.Class (MonadIO, liftIO)
import Control.Monad.Trans.Class (MonadTrans, lift)
import Control.Monad (liftM)

-- 1. MaybeT
newtype MaybeT m a = MaybeT { runMaybeT :: m (Maybe a)}

instance Functor m => Functor (MaybeT m) where
    fmap f (MaybeT x) = MaybeT $ (fmap . fmap) f x

instance Applicative m => Applicative (MaybeT m) where
    pure x = MaybeT (pure (pure x))
    MaybeT f <*> MaybeT x = MaybeT $ (<*>) <$> f <*> x

instance Monad m => Monad (MaybeT m) where
    return = pure
    MaybeT m >>= f = MaybeT $ do
        v <- m
        case v of
            Nothing -> return Nothing
            Just x -> runMaybeT (f x)
instance MonadTrans MaybeT where
  lift = MaybeT . fmap Just

instance (MonadIO m)  => MonadIO (MaybeT m) where
    liftIO = lift . liftIO

-- 2. ReaderT
newtype ReaderT r m a = { runReaderT :: r -> m a }

instance (Functor m) => Functor (ReaderT r m) where
    fmap f (ReaderT rma) = ReaderT $ (fmap . fmap) f rma

instance (Applicative m) => Applicative (ReaderT r m) where
    pure = ReaderT . pure . pure
    ReaderT rmab <*> ReaderT rma = ReaderT $ (<*>) <$> rmab <*> rma

instance (Monad m) => Monad (ReaderT r m) where
  return = pure
  (ReaderT rma) >>= f = ReaderT $ \r -> do
    a <- rma r
    runReaderT (f a) r

instance MonadTrans (ReaderT r) where
  lift :: Monad m => m a -> ReaderT r m a
  lift = ReaderT . const

instance (MonadIO m) => MonadIO (ReaderT r m) where
  liftIO :: IO a -> ReaderT r m a
  liftIO = lift . liftIO

-- 3. StateT

newtype StateT s m a = StateT { runStateT :: s -> m (a,s) }

instance (Functor m) => Functor (StateT s m) where
  fmap f (StateT smas) = StateT $ (fmap . fmap) f' smas
    where f' (a, s) = (f a, s)

instance (Monad m) => Applicative (StateT s m) where
  pure x = StateT $ \s -> pure (x, s)
  StateT smab <*> StateT sma = StateT $ \s -> do
    (f, s') <- smab s
    (a, s'')<- sma s'
    return $ (f a, s'')

instance (Monad m) => Monad (StateT s m) where
  return = pure
  StateT sma >>= f = StateT $ \s -> do
    (a, s') <- sma s
    runStateT (f a) s'

instance MonadTrans (StateT s) where
  lift :: Monad m => m a -> StateT s m a
  lift m = StateT $ \s -> do
    a <- m
    return $ (a, s)

instance (MonadIO m) => MonadIO (StateT s m) where
  liftIO :: IO a -> StateT s m a
  liftIO = lift . liftIO
