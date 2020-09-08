Exercise: Tuple experiment Look at the types given for
quotRem and divMod. What do you think those functions do?
CHAPTER 6. LESS AD-HOC POLYMORPHISM 277
Test your hypotheses by playing with them in the REPL. We’ve
given you a sample to start with below:
Prelude> ones x = snd (divMod x 10)

class (Real a, Enum a) => Integral a where
quot :: a -> a -> a
rem :: a -> a -> a
div :: a -> a -> a
mod :: a -> a -> a
quotRem :: a -> a -> (a, a)
divMod :: a -> a -> (a, a)
toInteger :: a -> Integer


Put on your thinking cap Why didn’t we need to make the
type of the function we wrote require both type classes? Why
didn’t we have to do this:
f :: (Num a, Fractional a) => a -> a -> a
Consider what it means for something to be a subset of a
larger set of objects.


Exercises: Will they work?
Next, take a look at the following code examples, and try to
decide if they will work, what result they will return if they do,
and why or why not (be sure, as always, to test them in your
REPL once you have decided on your answers):
1. max (length [1, 2, 3])
(length [8, 9, 10, 11, 12])
2. compare (3 * 4) (3 * 5)
3. compare "Julie" True
4. (5 + 3) > (3 + 6)

6.14 Chapter exercises
Multiple choice
1. The Eq class
a) includes all types in Haskell.
b) is the same as the Ord class.
c) makes equality tests possible.
d) only includes numeric types.
2. The type class Ord
CHAPTER 6. LESS AD-HOC POLYMORPHISM 316
a) allows any two values to be compared.
b) is a subclass of Eq.
c) is a superclass of Eq.
d) has no instance for Bool.
3. Suppose the type class Ord has an operator >. What is the
type of >?
a) Ord a => a -> a -> Bool
b) Ord a => Int -> Bool
c) Ord a => a -> Char
d) Ord a => Char -> [Char]
4. In x = divMod 16 12
a) the type of x is Integer.
b) the value of x is undecidable.
c) the type of x is a tuple.
d) x is equal to 12 / 16.
5. The type class Integral includes
a) Int and Integer numbers.
b) integral, real, and fractional numbers.
c) Schrodinger’s cat.
d) only positive numbers.
CHAPTER 6. LESS AD-HOC POLYMORPHISM 317
Does it type check?
For this section of exercises, you’ll be practicing looking for
type and type class errors.
For example, printIt will not work, because functions like x
have no instance of Show, the type class that lets you convert
things to String (usually for printing):
x :: Int -> Int
x blah = blah + 20
printIt :: IO ()
printIt = putStrLn (show x)
Here’s the type error you get if you try to load the code:
• No instance for (Show (Int -> Int))
arising from a use of ‘show’
(maybe you haven't applied a function
to enough arguments?)
• In the first argument of ‘putStrLn’,
namely ‘(show x)’
In the expression: putStrLn (show x)
In an equation for ‘printIt’:
printIt = putStrLn (show x)
It’s saying that it can’t find an implementation of the type
class Show for the type Int -> Int, which makes sense. Nothing
CHAPTER 6. LESS AD-HOC POLYMORPHISM 318
with the function type constructor, ->, has an instance of Show
by default in Haskell.6
Examine the following code, and decide whether it will type
check. Then load it in GHCi, and see if you were correct. If it
doesn’t type check, try to match the type error against your
understanding of why it didn’t work. If you can, fix the error
and re-run the code.
1. Does the following code type check? If not, why not?
data Person = Person Bool
printPerson :: Person -> IO ()
printPerson person = putStrLn (show person)
2. Does the following type check? If not, why not?
data Mood = Blah
| Woot deriving Show
settleDown x = if x == Woot
then Blah
else x
3. If you were able to get settleDown to type check:
6For an explanation and justification of why functions in Haskell cannot have a Show
instance, see the Haskell Wiki page on this topic: https://wiki.haskell.org/Show_instance_
for_functions
CHAPTER 6. LESS AD-HOC POLYMORPHISM 319
a) What values are acceptable inputs to that function?
b) What will happen if you try to run settleDown 9? Why?
c) What will happen if you try to run Blah > Woot? Why?
4. Does the following type check? If not, why not?
type Subject = String
type Verb = String
type Object = String
data Sentence =
Sentence Subject Verb Object
deriving (Eq, Show)
s1 = Sentence "dogs" "drool"
s2 = Sentence "Julie" "loves" "dogs"
Given a datatype declaration, what can we do?
Given the following datatype definitions:
data Rocks =
Rocks String deriving (Eq, Show)
data Yeah =
Yeah Bool deriving (Eq, Show)
CHAPTER 6. LESS AD-HOC POLYMORPHISM 320
data Papu =
Papu Rocks Yeah
deriving (Eq, Show)
Which of the following will type check? For the ones that
don’t type check, why don’t they?
1. phew = Papu "chases" True
2. truth = Papu (Rocks "chomskydoz")
(Yeah True)
3. equalityForall :: Papu -> Papu -> Bool
equalityForall p p' = p == p'
4. comparePapus :: Papu -> Papu -> Bool
comparePapus p p' = p > p'
Match the types
We’re going to give you two types and their implementations.
Then we’re going to ask you if you can substitute the second
type for the first. You can test this by typing the first declaration
and its type into a file and editing in the new one, loading to
see if it fails. Don’t guess—test all your answers!
1. For the following definition:
CHAPTER 6. LESS AD-HOC POLYMORPHISM 321
a) i :: Num a => a
i = 1
b) Try replacing the type signature with the following:
i :: a
After you’ve formulated your own answer, test that
answer. Use GHCi to check what type GHC infers for
the definitions we provide without a type assigned.
For this exercise, you’d type in:
Prelude> i = 1
Prelude> :t i
-- Result intentionally elided
2. a) f :: Float
f = 1.0
b) f :: Num a => a
3. a) f :: Float
f = 1.0
b) f :: Fractional a => a
4. Hint for the following: type :info RealFrac in your REPL:
a) f :: Float
f = 1.0
b) f :: RealFrac a => a
CHAPTER 6. LESS AD-HOC POLYMORPHISM 322
5. a) freud :: a -> a
freud x = x
b) freud :: Ord a => a -> a
6. a) freud' :: a -> a
freud' x = x
b) freud' :: Int -> Int
7. a) myX = 1 :: Int
sigmund :: Int -> Int
sigmund x = myX
b) sigmund :: a -> a
8. a) myX = 1 :: Int
sigmund' :: Int -> Int
sigmund' x = myX
b) sigmund' :: Num a => a -> a
9. a) You’ll need to import sort from Data.List:
jung :: Ord a => [a] -> a
jung xs = head (sort xs)
b) jung :: [Int] -> Int
CHAPTER 6. LESS AD-HOC POLYMORPHISM 323
10. a) young :: [Char] -> Char
young xs = head (sort xs)
b) young :: Ord a => [a] -> a
11. a) mySort :: [Char] -> [Char]
mySort = sort
signifier :: [Char] -> Char
signifier xs = head (mySort xs)
b) signifier :: Ord a => [a] -> a
Type-Kwon-Do Two: Electric typealoo
Round two! Same rules apply—you’re trying to fill in terms
(code) which will fit the types. The idea with these exercises is
that you’ll derive the implementations from the type information. You’ll probably need to use stuff from Prelude:
1. chk :: Eq b => (a -> b) -> a -> b -> Bool
chk = ???
2. Hint: use some arithmetic operation to combine values
of type b. Pick one:
CHAPTER 6. LESS AD-HOC POLYMORPHISM 324
arith :: Num b
=> (a -> b)
-> Integer
-> a
-> b
arith = ???
