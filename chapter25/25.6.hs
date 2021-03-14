module ComposeInstances where 

import Control.Applicative

newtype Compose f g a =
    Compose { getCompose :: f (g a) }
    deriving (Eq, Show)

instance (Functor f, Functor g) => 
          Functor (Compose f g) where
    fmap f (Compose fga) = 
      Compose $ (fmap . fmap) f fga
-- 1. 
instance (Foldable f, Foldable g ) => 
          Foldable (Compose f g) where
    foldMap f (Compose a) = (foldMap . foldMap) f a

-- 2. 
instance (Traversable f, Traversable g) =>
          Traversable (Compose f g) where
    traverse f (Compose a) = Compose <$> (traverse . traverse) f a