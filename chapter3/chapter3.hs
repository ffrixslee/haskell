-- Chapter 3. SIMPLE OPERATIONS WITH TEXT
-- print2.hs
module Print2 where

main :: IO ()
main = do
    putStrLn "Count to four for me:"
    putStrLn "one, two"
    putStrLn ", three, and"
    putStrLn " four!"

-- print3.hs
module Print3 where

  myGreeting :: String
  myGreeting = "hello" ++ " world!"

  hello :: String
  hello = "hello"

  world :: String
  world = "world!"

  main :: IO ()
  main = do
    putStrLn myGreeting
    putStrLn secondGreeting
    where secondGreeting =
            concat [hello, " ", world]

--TopOrLocal.hs
module TopOrLocal where

topLevelFunction :: Integer -> Integer
topLevelFunction x =
  x + woot + topLevelValue
  where woot :: Integer
        woot = 10

topLevelValue :: Integer
topLevelValue = 5

3.8 Chapter exercises
Reading syntax
1. For the following lines of code, read the syntax carefully,
and decide whether they are written correctly. Test them
in your REPL in order to check your work. Correct as
many as you can:
a) concat [[1, 2, 3], [4, 5, 6]]
b) ++ [1, 2, 3] [4, 5, 6]
c) (++) "hello" " world"
d) ["hello" ++ " world]
e) 4 !! "hello"
f ) (!!) "hello" 4
g) take "4 lovely"
h) take 3 "awesome"
2. Next, we have two sets. The first set is lines of code, and
the other is a set of results. Read the code, and figure out
which results come from which lines of code. Be sure to
test them in the REPL:
a) concat [[1 * 6], [2 * 6], [3 * 6]]
b) "rain" ++ drop 2 "elbow"
CHAPTER 3. SIMPLE OPERATIONS WITH TEXT 123
c) 10 * head [1, 2, 3]
d) (take 3 "Julie") ++ (tail "yes")
e) concat [tail [1, 2, 3],
tail [4, 5, 6],
tail [7, 8, 9]]
Now, match each of the previous expressions to one of
these results, which are presented in a scrambled order:
a) "Jules"
b) [2,3,5,6,8,9]
c) "rainbow"
d) [6,12,18]
e) 10
Building functions
1. Given the list-manipulation functions mentioned in this
chapter, write functions that take the given inputs and
return the expected outputs. Do them directly in your
REPL, and use the take and drop functions you’ve already
seen.
Example
If you apply your function to this value:
CHAPTER 3. SIMPLE OPERATIONS WITH TEXT 124
"Hello World"
Your function should return:
"ello World"
The following would be a fine solution:
Prelude> drop 1 "Hello World"
"ello World"
Now, write expressions to perform the following transformations, just with the functions you’ve seen in this
chapter. You do not need to do anything clever here:
a) -- Given
"Curry is awesome"
-- Return
"Curry is awesome!"
b) -- Given
"Curry is awesome!"
-- Return
"y"
c) -- Given
"Curry is awesome!"
-- Return
"awesome!"
CHAPTER 3. SIMPLE OPERATIONS WITH TEXT 125
2. Take each of the above, and rewrite it in a source file as a
general function that could take different string inputs as
arguments but retain the same behavior. Use a variable as
an argument to each of your (named) functions. If you’re
unsure how to do this, refresh your memory by looking
at the waxOff exercise from the previous chapter and the
TopOrLocal module from this chapter.
3. Write a function of type String -> Char that returns the
third character in a String. Remember to give the function
a name, and apply it to a variable, not a specific String,
so that it could be reused for different String inputs, as
demonstrated. Feel free to name the function something
else. Be sure to fill in both the type signature and the
function definition after the equals sign:
thirdLetter ::
thirdLetter x =
-- If you apply your function
-- to this value:
"Curry is awesome"
-- Your function should return:
'r'
Note that programming languages conventionally start
indexing things by zero, so getting the “zeroth” index of
CHAPTER 3. SIMPLE OPERATIONS WITH TEXT 126
a string will get you the first letter. Accordingly, indexing
with 3 will get you the fourth. Keep this in mind as you
write this function.
4. Change the above function so that the string operated on
is always the same and the variable represents the number
of the letter you want to return (you can use "Curry is
awesome!" as your string input or a different string, if you
prefer):
letterIndex :: Int -> Char
letterIndex x =
5. Using the take and drop functions we looked at above, see
if you can write a function called rvrs (an abbreviation of
“reverse,” used because there is already a function called
reverse in Prelude, so if you give your function the same
name, you’ll get an error message). rvrs should take the
string "Curry is awesome" and return the result "awesome is
Curry". This may not be the most lovely Haskell code you
will ever write, but it is entirely possible using only what
we’ve learned so far. First, write it as a single function in
a source file. This doesn’t need to, and shouldn’t, work
for reversing the words of any sentence. You’re expected
only to slice and dice this particular string with take and
drop.
CHAPTER 3. SIMPLE OPERATIONS WITH TEXT 127
6. Let’s see if we can expand that function into a module.
Why would we want to? By expanding it into a module,
we can add more functions later that can interact with
one another. We can also then export it to other modules
if we want to and use this code in those other modules.
There are different ways you could lay it out, but for the
sake of convenience, we’ll show you a sample layout so
that you can fill in the blanks:
module Reverse where
rvrs :: String -> String
rvrs x =
main :: IO ()
main = print ()
Into the parentheses after print, you’ll need to fill in your
function name, rvrs, plus the argument you’re applying
rvrs to, in this case "Curry is awesome". The rvrs function
plus its argument is now the argument to print. It’s important to put this function and argument combination
inside the parentheses, so that the function gets applied
and evaluated first, and then the result is printed.
Of course, we have also mentioned that you can use the $
function to avoid using parentheses, too. Try modifying
CHAPTER 3. SIMPLE OPERATIONS WITH TEXT 128
your main function to use that instead of parentheses.
