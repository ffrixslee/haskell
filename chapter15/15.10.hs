data Optional a =
    Nada
  | Only a
  deriving (Eq, Show)

instance Semigroup (Optional a) where
    (<>) Nada _ = Nada
    (<>) _ Nada = Nada
    (<>) Only a _ = Only a

instance Monoid (Semigroup) where
    mempty = Only a
