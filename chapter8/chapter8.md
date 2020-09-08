8.6 Chapter exercises
Review of types
1. What is the type of [[True, False], [True, True], [False,
True]]?
a) Bool
b) mostly True
c) [a]
d) [[Bool]]
2. Which of the following has the same type as [[True, False],
[True, True], [False, True]]?
a) [(True, False), (True, True), (False, True)]
b) [[3 == 3], [6 > 5], [3 < 4]]
c) [3 == 3, 6 > 5, 3 < 4]
d) ["Bool", "more Bool", "Booly Bool!"]
3. For the function below, which of the following statements
are true?
func :: [a] -> [a] -> [a]
func x y = x ++ y
a) x and y must be of the same type.
CHAPTER 8. FUNCTIONS THAT CALL THEMSELVES 446
b) x and y must both be lists.
c) If x is a String, then y must be a String.
d) All of the above.
4. For the func code above, which is a valid application of
func to both of its arguments?
a) func "Hello World"
b) func "Hello" "World"
c) func [1, 2, 3] "a, b, c"
d) func ["Hello", "World"]
Reviewing currying
Given the following definitions, tell us what value results from
further applications:
cattyConny :: String -> String -> String
cattyConny x y = x ++ " mrow " ++ y
-- fill in the types
flippy = flip cattyConny
appedCatty = cattyConny "woops"
frappe = flippy "haha"
CHAPTER 8. FUNCTIONS THAT CALL THEMSELVES 447
1. What is the value of appedCatty "woohoo!"? Try to determine the answer for yourself, then test it in the REPL.
2. frappe "1"
3. frappe (appedCatty "2")
4. appedCatty (frappe "blue")
5. cattyConny (frappe "pink")
(cattyConny "green"
(appedCatty "blue"))
6. cattyConny (flippy "Pugs" "are") "awesome"
Recursion
1. Write out the steps for reducing dividedBy 15 2 to its final
answer according to the Haskell code.
2. Write a function that recursively sums all numbers from
1 to n, n being the argument. So if n is 5, you’d add 1 + 2 +
3 + 4 + 5 to get 15. The type should be (Eq a, Num a) => a
-> a.
3. Write a function that multiplies two integral numbers
using recursive summation. The type should be (Integral
a) => a -> a -> a.
CHAPTER 8. FUNCTIONS THAT CALL THEMSELVES 448
Fixing dividedBy
Our dividedBy function wasn’t quite ideal. For one thing, it is
a partial function and doesn’t return a result (bottom) when
given a divisor that is 0 or less.
Using the pre-existing div function, we can see how negative
numbers should be handled:
Prelude> div 10 2
5
Prelude> div 10 (-2)
-5
Prelude> div (-10) (-2)
5
Prelude> div (-10) (2)
-5
The next issue is how to handle zero. Zero is undefined for
division in math, so we ought to use a datatype that lets us say
there is no sensible result when the user divides by zero. If
you need inspiration, consider using the following datatype to
handle this:
data DividedResult =
Result Integer
| DividedByZero
CHAPTER 8. FUNCTIONS THAT CALL THEMSELVES 449
McCarthy 91 function
We’re going to describe a function in English, then in math
notation, then show you what your function should return for
some test inputs. Your task is to write the function in Haskell.
The McCarthy 91 function yields x - 10 when x > 100 and
91 otherwise. The function is recursive:
𝑀𝐶(𝑛) =
⎧{
⎨{⎩
𝑛 − 10 if 𝑛 > 100
𝑀𝐶(𝑀𝐶(𝑛 + 11)) if 𝑛 ≤ 100
mc91 = undefined
You haven’t seen map yet, but all you need to know right
now is that it applies a function to each member of a list and
returns the resulting list. We’ll explain it in more detail in the
next chapter:
Prelude> map mc91 [95..110]
[91,91,91,91,91,91,91,92,93,94,95,96,97,98,
99,100]
CHAPTER 8. FUNCTIONS THAT CALL THEMSELVES 450
Numbers into words
module WordNumber where
import Data.List (intersperse)
digitToWord :: Int -> String
digitToWord n = undefined
digits :: Int -> [Int]
digits n = undefined
wordNumber :: Int -> String
wordNumber n = undefined
Here, undefined is a placeholder to show you where you need
to fill in the functions. The n to the right of the function names
is the argument that will be an integer.
Fill in the implementations of the functions above so that
wordNumber returns the English word version of the Int value.
You will first write a function that turns integers from 0–9
into their corresponding English words: “one,” “two,” and so
on. Then, you will write a function that takes the integer,
separates the digits, and returns it as a list of integers. Finally,
you will need to apply the first function to the list produced
by the second function and turn it into a single string with
CHAPTER 8. FUNCTIONS THAT CALL THEMSELVES 451
interspersed hyphens.
We’ve laid out multiple functions for you to consider as you
tackle the problem. You may not need all of them, depending
on how you solve it—these are just suggestions. Play with
them, and look up their documentation to understand them
in greater detail.
You will probably find this difficult:
div :: Integral a => a -> a -> a
mod :: Integral a => a -> a -> a
map :: (a -> b) -> [a] -> [b]
concat :: [[a]] -> [a]
intersperse :: a -> [a] -> [a]
(++) :: [a] -> [a] -> [a]
(:[]) :: a -> [a]
Also consider:
Prelude> div 135 10
13
Prelude> mod 135 10
5
Prelude> div 13 10
1
Prelude> mod 13 10
3
CHAPTER 8. FUNCTIONS THAT CALL THEMSELVES 452
Here is what your REPL output should look like when it’s
working:
Prelude> wordNumber 12324546
"one-two-three-two-four-five-four-six"
