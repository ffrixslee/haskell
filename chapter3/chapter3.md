Exercises: Scope
1. These lines of code are from a REPL session. Is y in scope
for z?
Prelude> x = 5
Prelude> y = 7
Prelude> z = x * y
2. These lines of code are from a REPL session. Is h in scope
for g? Go with your gut here:
Prelude> f = 3
Prelude> g = 6 * f + h
3. This code sample is from a source file. Is everything we
need to execute area in scope?
CHAPTER 3. SIMPLE OPERATIONS WITH TEXT 111
area d = pi * (r * r)
r = d / 2
4. This code is also from a source file. Now, are r and d in
scope for area?
area d = pi * (r * r)
where r = d / 2

Exercises: Syntax errors
Read the syntax of the following functions, and decide whether
it will compile. Test them in your REPL, and try to fix the syntax
errors where they occur:
1. ++ [1, 2, 3] [4, 5, 6]
  (correct solution): [1, 2, 3]++[4, 5, 6]
[1,2,3,4,5,6]
2. '<3' ++ ' Haskell'
3. concat ["<3", " Haskell"]


3.6 Concatenation and scoping
We will use parentheses to call (++) as a prefix (not infix) function:
-- print3flipped.hs
module Print3Flipped where
myGreeting :: String
myGreeting = (++) "hello" " world!"
hello :: String
hello = "hello"
world :: String
world = "world!"
CHAPTER 3. SIMPLE OPERATIONS WITH TEXT 116
main :: IO ()
main = do
putStrLn myGreeting
putStrLn secondGreeting
where secondGreeting =
(++) hello ((++) " " world)
-- could've been:
-- secondGreeting =
-- hello ++ " " ++ world
In secondGreeting, using (++) as a prefix function forces us
to shift some things around. Parenthesizing it that way emphasizes its right associativity. Since it’s an infix operator, you
can check for yourself that it’s right associative:
Prelude> :i (++)
(++) :: [a] -> [a] -> [a]
infixr 5 ++
The where clause creates local bindings for expressions that
are not visible at the top level. In other words, the where clause
in main introduces a definition visible only within the expression or function it’s attached to, rather than making it visible to
the entire module. Something visible at the top level is in scope
for all parts of the module and may be exported by the module
or imported by a different module. Local definitions, on the
CHAPTER 3. SIMPLE OPERATIONS WITH TEXT 117
other hand, are only visible to that one function. You cannot
import into a different module and reuse secondGreeting.
To illustrate:
-- print3broken.hs
module Print3Broken where
printSecond :: IO ()
printSecond = do
putStrLn greeting
main :: IO ()
main = do
putStrLn greeting
printSecond
where greeting = "Yarrrrr"
You should get an error like this:
Prelude> :l print3broken.hs
[1 of 1] Compiling Print3Broken
print3broken.hs:6:12: error:
Variable not in scope:
greeting :: String
|
9 | putStrLn greeting
CHAPTER 3. SIMPLE OPERATIONS WITH TEXT 118
| ^^^^^^^^
Failed, no modules loaded.
Let’s take a closer look at this error:
print3broken.hs:6:12: error:
[1][2]
Variable not in scope:
[ 3 ]
greeting :: String
[ 4 ]
1. The line the error occurs on: in this case, line 6.
2. The column the error occurs on: column 12. Text on computers is often described in terms of lines and columns.
These line and column numbers are about lines and
columns in your text file containing the source code.
3. The actual problem: we refer to something not in scope,
that is, not visible to the printSecond function.
4. The thing we refer to that isn’t visible, or in scope.
Now, make the Print3Broken code compile. It should print
"Yarrrrr" twice on two different lines and then exit.
