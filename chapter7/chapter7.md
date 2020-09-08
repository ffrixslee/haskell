Exercises: Grab bag
Note that the following exercises are from source code files,
not written for use directly in the REPL. Of course, you can
change them to test directly in the REPL, if you prefer.
1. Which (two or more) of the following are equivalent?
a) mTh x y z = x * y * z
b) mTh x y = \z -> x * y * z
c) mTh x = \y -> \z -> x * y * z
1
In GHCi error messages, it refers to the last expression you entered in the REPL.
CHAPTER 7. MORE FUNCTIONAL PATTERNS 343
d) mTh = \x -> \y -> \z -> x * y * z
2. The type of mTh (above) is Num a => a -> a -> a -> a.
Which is the type of mTh 3?
a) Integer -> Integer -> Integer
b) Num a => a -> a -> a -> a
c) Num a => a -> a
d) Num a => a -> a -> a
3. Next, we’ll practice writing anonymous lambda syntax.
For example, one could rewrite:
addOne x = x + 1
Into:
addOne = \x -> x + 1
Try to make it so it can still be loaded as a top-level definition by GHCi. This will make it easier to validate your
answers.
a) Rewrite the f function in the where clause:
addOneIfOdd n = case odd n of
True -> f n
False -> n
where f n = n + 1
CHAPTER 7. MORE FUNCTIONAL PATTERNS 344
b) Rewrite the following to use anonymous lambda syntax:
addFive x y = (if x > y then y else x) + 5
c) Rewrite the following so that it doesn’t use anonymous lambda syntax:
mflip f = \x -> \y -> f y x


Exercises: Variety pack
1. Given the following declarations:
k (x, y) = x
k1 = k ((4-1), 10)
k2 = k ("three", (1 + 2))
k3 = k (3, True)
a) What is the type of k?
b) What is the type of k2? Is it the same type as k1 or k3?
c) Of k1, k2, k3, which will return the number 3 as the
result?
2. Fill in the definition of the following function:
f :: (a, b, c)
-> (d, e, f)
-> ((a, d), (c, f))
f = undefined
Remember that tuples have the same syntax for their type
constructors and their data constructors.


Exercises: Guard duty
1. It is probably clear to you why you wouldn’t put an otherwise
in your top-most guard, but try it with avgGrade anyway,
and see what happens. It’ll be clearer if you rewrite it
as an otherwise match: | otherwise = 'F'. What happens
now if you pass 90 as an argument? 75? 60?
2. What happens if you take avgGrade as it is written and
reorder the guards? Does it still type check and work the
same way? Try moving | y >= 0.7 = 'C' and passing it the
argument 90, which should be an 'A'. Does it return 'A'?
3. What does the following function return?
CHAPTER 7. MORE FUNCTIONAL PATTERNS 385
pal xs
| xs == reverse xs = True
| otherwise = False
a) xs written backwards when it’s True.
b) True when xs is a palindrome.
c) False when xs is a palindrome.
d) False when xs is reversed.
4. What types of arguments can pal take?
5. What is the type of the function pal?
6. What does the following function return?
numbers x
| x < 0 = -1
| x == 0 = 0
| x > 0 = 1
a) The value of its argument plus or minus 1.
b) The negation of its argument.
c) An indication of whether its argument is a positive
or negative number or 0.
d) Binary machine language.
7. What types of arguments can numbers take?
CHAPTER 7. MORE FUNCTIONAL PATTERNS 386
8. What is the type of the function numbers?


7.11 Chapter exercises
Multiple choice
1. A polymorphic function:
a) Changes things into sheep when invoked.
CHAPTER 7. MORE FUNCTIONAL PATTERNS 400
b) Has multiple arguments.
c) Has a concrete type.
d) May resolve to values of different types, depending
on inputs.
2. Two functions named f and g have types Char -> String
and String -> [String], respectively. The composed function g . f has the type:
a) Char -> String
b) Char -> [String]
c) [[String]]
d) Char -> String -> [String]
3. A function f has the type Ord a => a -> a -> Bool, and we
apply it to one numeric value. What is the type now?
a) Ord a => a -> Bool
b) Num -> Num -> Bool
c) Ord a => a -> a -> Integer
d) (Ord a, Num a) => a -> Bool
4. A function with the type (a -> b) -> c:
a) Requires values of three different types.
b) Is a higher-order function.
CHAPTER 7. MORE FUNCTIONAL PATTERNS 401
c) Must take a tuple as its first argument.
d) Has its parameters in alphabetical order.
5. Given the following definition of f, what is the type of f
True?
f :: a -> a
f x = x
a) f True :: Bool
b) f True :: String
c) f True :: Bool -> Bool
d) f True :: a
Let’s write code
1. The following function returns the tens digit of an integral
argument:
tensDigit :: Integral a => a -> a
tensDigit x = d
where xLast = x `div` 10
d = xLast `mod` 10
a) First, rewrite it using divMod.
b) Does the divMod version have the same type as the
original version?
CHAPTER 7. MORE FUNCTIONAL PATTERNS 402
c) Next, let’s change it so that we’re getting the hundreds
digit instead. You could start it like this (though that
may not be the only possibility):
hunsD x = d2
where d = undefined
...
2. Implement the following function of the type a -> a ->
Bool -> a once using a case expression and once with a
guard:
foldBool :: a -> a -> Bool -> a
foldBool =
error
"Error: Need to implement foldBool!"
The result is semantically similar to if-then-else expressions but syntactically quite different. Here is the pattern
matching version to get you started:
foldBool3 :: a -> a -> Bool -> a
foldBool3 x _ False = x
foldBool3 _ y True = y
3. Fill in the definition. Note that the first argument to our
function is also a function that can be applied to values.
CHAPTER 7. MORE FUNCTIONAL PATTERNS 403
Your second argument is a tuple, which can be used for
pattern matching:
g :: (a -> b) -> (a, c) -> (b, c)
g = undefined
4. For this next exercise, you’ll experiment with writing
point-free versions of existing code. This involves some
new information, so read the following explanation carefully.
Type classes are dispatched by type. Read is a type class
like Show, but it is the dual or “opposite” of Show. In general,
the Read type class isn’t something you should plan to use,
but this exercise is structured to teach you something
about the interaction between type classes and types.
The function read in the Read type class has the type:
read :: Read a => String -> a
Notice a pattern?
read :: Read a => String -> a
show :: Show a => a -> String
Type the following code into a source file. Then load it,
and run it in GHCi to make sure you understand why the
evaluation results in the answers you see:
CHAPTER 7. MORE FUNCTIONAL PATTERNS 404
-- arith4.hs
module Arith4 where
roundTrip :: (Show a, Read a) => a -> a
roundTrip a = read (show a)
main = do
print (roundTrip 4)
print (id 4)
5. Next, write a point-free version of roundTrip. (n.b., this
refers to the function definition, not to its application in
main.)
6. We will continue to use the code in module Arith4 for this
exercise, as well.
When we apply show to a value such as (1 :: Int), the a
that implements Show is type Int, so GHC will use the Int
instance of the Show type class to stringify our Int value 1.
However, read expects a String argument in order to return an a. The String argument that is the first argument
to read tells the function nothing about what type the destringified result should be. In the type signature roundTrip
currently has, it knows, because the type variables are the
same, so the type that is the input to show has to be the
same type as the output of read.
CHAPTER 7. MORE FUNCTIONAL PATTERNS 405
Your task now is to change the type of roundTrip in Arith4 to
(Show a, Read b) => a -> b. How might we tell GHC which
instance of Read to dispatch against the String? Make the
expression print (roundTrip 4) work. You will only need
the has the type syntax of :: and parentheses for scoping.
