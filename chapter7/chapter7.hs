funcZ x =
  case x + 1 == 1 of
    True -> "AWESOME"
    FALSE -> "wut"


pal xs =
  case xs == reverse xs of
    True -> "yes"
    False -> "no"

pal' xs =
  case y of
    True -> "yes"
    False -> "no"
where y = xs == reverse xs

Exercises: Case practice
We’re going to practice using case expressions by rewriting
functions. Some of these functions you’ve seen in previous
chapters (and some you’ll see later using different syntax, yet
again!), but you’ll be writing new versions now. Please note,
these are all written as they would be in source code files, and
we recommend you write your answers in source files, and
then load them into GHCi to check, rather than trying to do
them directly in the REPL.
First, rewrite if-then-else expressions into case expressions.
1. The following should return x when x is greater than y:
functionC x y = if (x > y) then x else y
2. The following will add 2 to even numbers and otherwise
simply return the input value:
ifEvenAdd2 n = if even n then (n+2) else n
The next exercise doesn’t have all the cases covered. See
if you can fix it.
3. The following compares a value, x, to 0 and returns an
indicator for whether x is a positive number or negative
number. What if x is 0? You may need to play with the
compare function a bit to find what to do:
CHAPTER 7. MORE FUNCTIONAL PATTERNS 364
nums x =
case compare x 0 of
LT -> -1
GT -> 1


Exercises: Artful dodgy
Given the following definitions, tell us what value results from
further applications. When you’ve written down at least some
of the answers and think you know what’s what, type the definitions into a file, and load them in GHCi to test your answers:
-- Types not provided,
-- try filling them in yourself.
dodgy x y = x + y * 10
oneIsOne = dodgy 1
oneIsTwo = (flip dodgy) 2
1. For example, given the expression dodgy 1 0, what do
you think will happen if we evaluate it? If you put the
definitions in a file and load them in GHCi, you can do
the following to see the result:
Prelude> dodgy 1 0
1
Now, attempt to determine what the following expressions reduce to. Do each one in your head, and verify
your answer in the REPL after you think you have one:
2. dodgy 1 1
CHAPTER 7. MORE FUNCTIONAL PATTERNS 376
3. dodgy 2 2
4. dodgy 1 2
5. dodgy 2 1
6. oneIsOne 1
7. oneIsOne 2
8. oneIsTwo 1
9. oneIsTwo 2
10. oneIsOne 3
11. oneIsTwo 3
