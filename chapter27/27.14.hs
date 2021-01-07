-- Strict list

{-# LANGUAGE Strict #-}
module StrictList where
data List a =
Nil |
Cons a (List a)
deriving (Show)
take' n _ | n <= 0 = Nil
take' _ Nil = Nil
take' n (Cons x xs) =
(Cons x (take' (n-1) xs))
map' _ Nil = Nil
map' f (Cons x xs) =
(Cons (f x) (map' f xs))
repeat' x = xs where xs = (Cons x xs)
main = do
print $ take' 10 $ map' (+1) (repeat' 1)

-- What will sprint output?
1. let x = 1
2. let x = ['1']
3. let x = [1]
4. let x = 1 :: Int
5. let f = \x -> x
let x = f 1
6. let f :: Int -> Int; f = \x -> x
let x = f 1

-- Will printing this expression result in bottom?
1. snd (undefined, 1)
2. let x = undefined
let y = x `seq` 1 in snd (x, y)
3. length $ [1..5] ++ undefined
4. length $ [1..5] ++ [undefined]
5. const 1 undefined
6. const 1 (undefined `seq` 1)
7. const undefined 1

-- Make the expression bottom
Using only bang patterns or seq, make the code bottom out
when executed:
1. x = undefined
y = "blah"
main = do
print (snd (x, y))