Exercise: EnumFromTo
Some things you’ll want to know about the Enum type class:
Prelude> :info Enum
class Enum a where
succ :: a -> a
pred :: a -> a
toEnum :: Int -> a
fromEnum :: a -> Int
enumFrom :: a -> [a]
enumFromThen :: a -> a -> [a]
enumFromTo :: a -> a -> [a]
enumFromThenTo :: a -> a -> a -> [a]
Prelude> succ 0
CHAPTER 9. THIS THING AND SOME MORE STUFF 464
1
Prelude> succ 1
2
Prelude> succ 'a'
'b'
Write your own enumFromTo definitions for the types provided.
Do not use range syntax to do so. It should return the same
results as if you did [start..stop]. Replace the undefined, a
value that results in an error when evaluated, with your own
definition.
eftBool :: Bool -> Bool -> [Bool]
eftBool = undefined
eftOrd :: Ordering
-> Ordering
-> [Ordering]
eftOrd = undefined
eftInt :: Int -> Int -> [Int]
eftInt = undefined
eftChar :: Char -> Char -> [Char]
eftChar = undefined


Exercises: Comprehend thy lists
Take a look at the following functions, determine what you
think the output lists will be, and then run them in your REPL
to verify (note that you will need the mySqr list from above in
scope to do this):
CHAPTER 9. THIS THING AND SOME MORE STUFF 477
[x | x <- mySqr, rem x 2 == 0]
[(x, y) | x <- mySqr,
y <- mySqr,
x < 50, y > 50]
take 5 [ (x, y) | x <- mySqr,
y <- mySqr,
x < 50, y > 50 ]
List comprehensions with strings
It’s worth remembering that strings are lists, so list comprehensions can also be used with strings. We’re going to introduce
a standard function called elem1
that tells you whether an element is in a list or not. It evaluates to a Bool value, so it is useful
as a predicate in list comprehensions:
Prelude> :t elem
elem :: Eq a => a -> [a] -> Bool
Prelude> elem 'a' "abracadabra"
True
Prelude> elem 'a' "Julie"
False
1Reminder, pretend Foldable in the type of elem means it’s a list until we cover Foldable
later.
CHAPTER 9. THIS THING AND SOME MORE STUFF 478
In the first case, 'a' is an element of "abracadabra", so that
evaluates to True, but in the second case, there is no 'a' in
"Julie", so we get a False result. As you can see from the type
signature, elem doesn’t only work with characters and strings,
but that’s what we’ll use it for here. Let’s see if we can write a
list comprehension to remove all the lowercase letters from
a string. Here, our condition is that we only want to take x
from our generator list when it meets the condition that it is
an element of the list of capital letters:
Prelude> :{
Prelude| [x |
Prelude| x <- "Three Letter Acronym",
Prelude| elem x ['A'..'Z']]
Prelude| :}
"TLA"
Let’s see if we can now generalize this into an acronym
generator that will accept different strings as inputs, instead of
forcing us to rewrite the whole list comprehension for every
string we might want to feed it. We will do this by naming
a function that will take one argument and use that as the
generator string for our list comprehension. So, the function
argument and the generator string will need to be the same
thing:
Prelude> :{
CHAPTER 9. THIS THING AND SOME MORE STUFF 479
Prelude| let acro xs =
Prelude| [x | x <- xs,
Prelude| elem x ['A'..'Z']]
Prelude| :}
We use xs for our function argument to indicate to ourselves
that it’s a list, that the x is plural. It doesn’t have to be; you
could use a different variable there and obtain the same result.
It is idiomatic to use a “plural” variable for list arguments, but
it is not a requirement.
All right, so we have our acro function with which we can
generate acronyms from any string:
Prelude> s = "Self"
Prelude> c = " Contained"
Prelude> u = " Underwater"
Prelude> b = " Breathing"
Prelude> a = " Apparatus"
Prelude> scuba = s ++ c ++ u ++ b ++ a
Prelude> acro scuba
"SCUBA"
Prelude> n = "National"
Prelude> a = " Aeronautics and"
Prelude> s = " Space"
Prelude> a' = " Administration"
Prelude> nasa = n ++ a ++ s ++ a'
CHAPTER 9. THIS THING AND SOME MORE STUFF 480
Prelude> acro nasa
"NASA"
Given the above, what do you think this function would do:
Prelude> myString xs = [x | x <- xs, elem x "aeiou"]
Exercises: Square cube
Given the following:
Prelude> mySqr = [x^2 | x <- [1..5]]
Prelude> myCube = [y^3 | y <- [1..5]]
1. First write an expression that will make tuples of the
outputs of mySqr and myCube.
2. Now, alter that expression so that it only uses the x and y
values that are less than 50.
3. Apply another function to that list comprehension to
determine how many tuples inhabit your output list.


Exercises: Bottom madness
Will it blow up?
Will the following expressions return a value or be ⊥?
1. [x^y | x <- [1..5], y <- [2, undefined]]
2. take 1 $
[x^y | x <- [1..5], y <- [2, undefined]]
3. sum [1, undefined, 3]
4. length [1, 2, undefined]
5. length $ [1, 2, 3] ++ undefined
6. take 1 $ filter even [1, 2, 3, undefined]
7. take 1 $ filter even [1, 3, undefined]
8. take 1 $ filter odd [1, 3, undefined]
CHAPTER 9. THIS THING AND SOME MORE STUFF 494
9. take 2 $ filter odd [1, 3, undefined]
10. take 3 $ filter odd [1, 3, undefined]
Intermission: Is it in normal form?
For each expression below, determine whether it’s in:
1. Normal form, which implies weak head normal form.
2. Weak head normal form only.
3. Neither.
Remember that an expression cannot be in normal form or
weak head normal form if the outermost part of the expression
isn’t a data constructor. It can’t be in normal form if any part
of the expression is unevaluated:
1. [1, 2, 3, 4, 5]
2. 1 : 2 : 3 : 4 : _
3. enumFromTo 1 10
4. length [1, 2, 3, 4, 5]
5. sum (enumFromTo 1 10)
6. ['a'..'m'] ++ ['n'..'z']
7. (_, 'b')

Exercises: More bottoms
As always, we encourage you to try figuring out the answers
before you enter them into your REPL:
1. Will the following expression return a value or be ⊥?
take 1 $ map (+1) [undefined, 2, 3]
2. Will the following expression return a value?
take 1 $ map (+1) [1, undefined, 3]
3. Will the following expression return a value?
take 2 $ map (+1) [1, undefined, 3]
4. What does the following mystery function do? What is its
type? Describe it (to yourself or a loved one) in standard
English and then test it out in the REPL to make sure you
are correct:
CHAPTER 9. THIS THING AND SOME MORE STUFF 505
itIsMystery xs =
map (\x -> elem x "aeiou") xs
5. What will be the result of the following functions:
a) map (^2) [1..10]
b) map minimum [[1..10], [10..20], [20..30]]
-- n.b. minimum is not the same function
-- as the min function that we used before
c) map sum [[1..5], [1..5], [1..5]]
6. Back in Chapter 7, you wrote a function called foldBool.
That function exists in a module known as Data.Bool and
is called bool. Write a function that does the same (or
similar, if you wish) as the map if-then-else function you
saw above but uses bool instead of the if-then-else syntax.
Your first step should be bringing the bool function into
scope by typing import Data.Bool at your REPL prompt.


Exercises: Filtering
1. Given the above, how might we write a filter function that
would give us all the multiples of 3 out of a list from 1–30?
CHAPTER 9. THIS THING AND SOME MORE STUFF 508
2. Recalling what we learned about function composition,
how could we compose the above function with the length
function to tell us how many multiples of 3 there are between 1 and 30?
3. Next, we’re going to work on removing all articles (“the,”
“a,” and “an”) from sentences. You want to get to something
that works like this:
Prelude> myFilter "the brown dog was a goof"
["brown","dog","was","goof"]
You may recall that earlier in this chapter, we asked you
to write a function that separates a string into a list of
strings by separating them at spaces. That is a standard library function called words. You may consider starting this
exercise by using words (or your own version, of course).


Zipping exercises
1. Write your own version of zip, and ensure it behaves the
same as the original:
zip :: [a] -> [b] -> [(a, b)]
zip = undefined
CHAPTER 9. THIS THING AND SOME MORE STUFF 512
2. Do what you did for zip but now for zipWith:
zipWith :: (a -> b -> c)
-> [a] -> [b] -> [c]
zipWith = undefined
3. Rewrite your zip in terms of the zipWith you wrote.
9.12 Chapter exercises
The first set of exercises here will mostly be review but will
also introduce you to some new things. The second set is
more conceptually challenging but does not use any syntax or
concepts we haven’t already studied. If you get stuck, it may
help to flip back to a relevant section and review.
Data.Char
These first few exercises are straightforward but will introduce
you to some new library functions and review some of what
we’ve learned so far. Some of the functions we will use here
are not standard in Prelude and so have to be imported from
a module called Data.Char. You may do so in a source file
(recommended) or at the Prelude prompt with the same phrase:
import Data.Char (write that at the top of your source file). This
brings into scope a bunch of new standard functions we can
play with that operate on Char and String types.
CHAPTER 9. THIS THING AND SOME MORE STUFF 513
1. Query the types of isUpper and toUpper.
2. Given the following behaviors, which would we use to
write a function that filters all the uppercase letters out of
a String? Write that function such that, given the input
"HbEfLrLxO", your function will return "HELLO".
Prelude Data.Char> isUpper 'J'
True
Prelude Data.Char> toUpper 'j'
'J'
3. Write a function that will capitalize the first letter of a
string and return the entire string. For example, if given
the argument "julie", it will return "Julie".
4. Now make a new version of that function that is recursive,
such that if you give it the input "woot", it will holler back
at you "WOOT". The type signature won’t change, but you
will want to add a base case.
5. To do the final exercise in this section, we’ll need another
standard function for lists called head. Query the type
of head, and experiment with it to see what it does. Now
write a function that will capitalize the first letter of a
String and return only that letter as the result.
CHAPTER 9. THIS THING AND SOME MORE STUFF 514
6. Cool. Good work. Now rewrite it as a composed function.
Then, for fun, rewrite it point-free.
Ciphers
We’ll still be using Data.Char for this next exercise. You should
save these exercises in a module called Cipher, because we’ll
be coming back to them in later chapters. You’ll be writing a
Caesar cipher for now, but we’ll suggest some variations on
the basic program in later chapters.
A Caesar cipher is a simple substitution cipher, in which
each letter is replaced by the letter that is a fixed number of
places down the alphabet from it. You will find variations on
this all over the place—you can shift leftward or rightward, for
any number of spaces. A rightward shift of three means that
'A' will become 'D', and 'B' will become 'E', for example. If
you do a leftward shift of five, then 'a' would become 'v', and
so forth.
Your goal in this exercise is to write a basic Caesar cipher
that shifts rightward. You can start by having the number of
spaces to shift fixed, but it’s more challenging to write a cipher
that allows you to vary the number of shifts so that you can
encode your secret messages differently each time.
There are Caesar ciphers written in Haskell all over the internet, but to maximize the likelihood that you can write yours
without peeking at those, we’ll provide a couple of tips. When
CHAPTER 9. THIS THING AND SOME MORE STUFF 515
yours is working the way you want it to, we would encourage
you to then look around and compare your solution to others
out there.
The first lines of your text file should look like this:
module Cipher where
import Data.Char
Data.Char includes two functions called ord and chr that can
be used to associate a Char with its Int representation in the
Unicode system and vice versa:
*Cipher> :t chr
chr :: Int -> Char
*Cipher> :t ord
ord :: Char -> Int
Using these functions is optional; there are other ways you
can proceed with shifting, but using chr and ord might simplify
the process a bit.
You want your shift to wrap back around to the beginning
of the alphabet, so that if you have a rightward shift of three
from 'z', you end up back at 'c' and not somewhere in the
vast Unicode hinterlands. Depending on how you’ve set things
up, this might be a bit tricky. Consider starting from a base
CHAPTER 9. THIS THING AND SOME MORE STUFF 516
character (e.g., 'a') and using mod to ensure you’re only shifting
over the 26 standard characters of the English alphabet.
You should include an unCaesar function that will decipher
your text, as well. In a later chapter, we will test it.
Writing your own standard functions
Below are the outlines of some standard functions. The goal
here is to write your own versions of these to gain a deeper
understanding of recursion over lists and how to make functions flexible enough to accept a variety of inputs. You could
figure out how to look up the answers, but you won’t do that,
because you know you’d only be cheating yourself out of the
knowledge. Right?
Let’s look at an example of what we’re after here. The and2
function takes a list of Bool values and returns True if and only
if no values in the list are False. Here’s how you might write
your own version of it:
2Note that if you’re using GHC 7.10 or newer, the functions and, any, and all have been
abstracted from being usable only with lists to being usable with any datatype that has
an instance of the type class Foldable. It still works with lists, the same as it did before.
Proceed assured that we’ll cover this later.
CHAPTER 9. THIS THING AND SOME MORE STUFF 517
-- direct recursion, not using (&&)
myAnd :: [Bool] -> Bool
myAnd [] = True
myAnd (x:xs) =
if x == False
then False
else myAnd xs
-- direct recursion, using (&&)
myAnd :: [Bool] -> Bool
myAnd [] = True
myAnd (x:xs) = x && myAnd xs
And now the fun begins:
1. myOr returns True if any Bool in the list is True:
myOr :: [Bool] -> Bool
myOr = undefined
2. myAny returns True if a -> Bool applied to any of the values
in the list returns True:
myAny :: (a -> Bool) -> [a] -> Bool
myAny = undefined
Example for validating myAny:
CHAPTER 9. THIS THING AND SOME MORE STUFF 518
Prelude> myAny even [1, 3, 5]
False
Prelude> myAny odd [1, 3, 5]
True
3. After you write the recursive myElem, write another version
that uses any. The built-in version of elem in GHC 7.10 and
newer has a type that uses Foldable instead of the list type,
specifically. You can ignore that and write the concrete
version that works only for lists:
myElem :: Eq a => a -> [a] -> Bool
Prelude> myElem 1 [1..10]
True
Prelude> myElem 1 [2..10]
False
4. Implement myReverse:
myReverse :: [a] -> [a]
myReverse = undefined
Prelude> myReverse "blah"
"halb"
Prelude> myReverse [1..5]
[5,4,3,2,1]
CHAPTER 9. THIS THING AND SOME MORE STUFF 519
5. squish flattens a list of lists into a list:
squish :: [[a]] -> [a]
squish = undefined
6. squishMap maps a function over a list and concatenates the
results:
squishMap :: (a -> [b]) -> [a] -> [b]
squishMap = undefined
Prelude> squishMap (\x -> [1, x, 3]) [2]
[1,2,3]
Prelude> squishMap (\x -> "WO "++[x]++" HOO ") "123"
"WO 1 HOO WO 2 HOO WO 3 HOO "
7. squishAgain flattens a list of lists into a list. This time, reuse the squishMap function:
squishAgain :: [[a]] -> [a]
squishAgain = undefined
8. myMaximumBy takes a comparison function and a list and
returns the greatest element of the list based on the last
value that the comparison returns GT for. If you import
maximumBy from Data.List, you’ll see that the type is:
Foldable t => (a -> a -> Ordering)
-> t a -> a
CHAPTER 9. THIS THING AND SOME MORE STUFF 520
Rather than:
(a -> a -> Ordering) -> [a] -> a
myMaximumBy :: (a -> a -> Ordering)
-> [a] -> a
myMaximumBy = undefined
Prelude> xs = [1, 53, 9001, 10]
Prelude> myMaximumBy compare xs
9001
9. myMinimumBy takes a comparison function and a list and
returns the least element of the list based on the last value
that the comparison returns LT for:
myMinimumBy :: (a -> a -> Ordering)
-> [a] -> a
myMinimumBy = undefined
Prelude> xs = [1, 53, 9001, 10]
Prelude> myMinimumBy compare xs
1
10. Using the myMinimumBy and myMaximumBy functions, write your
own versions of maximum and minimum. If you have GHC 7.10
CHAPTER 9. THIS THING AND SOME MORE STUFF 521
or newer, you’ll see a type constructor that wants a Foldable
instance instead of a list, as has been the case for many
functions so far:
myMaximum :: (Ord a) => [a] -> a
myMaximum = undefined
myMinimum :: (Ord a) => [a] -> a
myMinimum = undefined
