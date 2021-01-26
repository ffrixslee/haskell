-- programmers usually need to pass around some information universally throughout an entire application. However, we don't want to always have to pass this information as arguments, therefore Reader comes in useful.

-- Example from section 22.2
import Control.Applicative 

boop = (*2)
doop = (+10)

bip :: Integer -> Integer
bip = boop . doop

bloop :: Integer -> Integer
bloop = fmap boop doop
-- fmap boop doop == (*2) ((+10) x)

-- Applicative context
bbop :: Integer -> Integer
bbop :: (+) <$> boop <*> doop

duwop :: Integer -> Integer
duwop = liftA2 (+) boop doop