-- Short Exercise: Warming up
import Data.Char

cap :: [Char] -> [Char]
cap xs = map toUpper xs

rev :: [Char] -> [Char]
rev xs = reverse xs

composed :: [Char] -> [Char]
composed = cap . rev

fmapped :: [Char] -> [Char]
fmapped = fmap cap rev

tupled :: [Char] -> ([Char],[Char])
tupled = (,) <$> cap <*> rev

monadFun :: [Char] -> ([Char],[Char])
monadFun = do
    x <- cap
    y <- rev
    return (x,y)

bindFun :: [Char] -> ([Char],[Char])
bindFun = cap >>= fmap (,) rev