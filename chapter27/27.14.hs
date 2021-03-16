{-# LANGUAGE Strict #-}
{-# LANGUAGE BangPatterns #-}

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

-- type in the REPL
-- 1.

let x1 = 1

-- x1 = _

-- 2.

let x2 = ['1']

-- x2 = "1"

-- 3.

let x3 = [1]

-- x3 = _

-- 4.

let x4 = 1 :: Int

-- x4 = 1

-- 5.

let f = \x -> x
let x5 = f 1

-- x5 = _

-- 6.

let f' :: Int -> Int; f' = \x -> x
let x6 = f' 1

-- x6 = _


-- Will printing this expression result in bottom?
-- 1.

snd (undefined, 1)

-- No

-- 2.

let x = undefined
let y = x `seq` 1 in snd (x, y)

-- Yes

-- 3.

length $ [1..5] ++ undefined

-- Yes

-- 4.

length $ [1..5] ++ [undefined]

-- No

-- 5.

const 1 undefined

-- No

-- 6.

const 1 (undefined `seq` 1)

-- No

-- 7.

const undefined 1

-- Yes


-- Make the expression bottom
x = undefined
y = "blah"

-- No bottom
main = do
  print (snd (x, y))

-- Bottom
main1 = do
  print $ f (x, y)
  where f (!x, y) = snd (x, y)

-- Bottom
main2 = do
  print $ x `seq` (snd (x, y))