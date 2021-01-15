module Main where
import System.Environment

-- Takes the first element of the argument list, concat it onto the end of the string "Hello," and finally pass that to putStrLn which creates new IO action, participating in the do-block sequencing.
{-
main :: IO ()
main = do
    args <- getArgs
    putStrLn ("Hello, " ++ args !! 0)
-}

-- Exercises
-- 1.
-- Change the program so it reads two arguments from the command line, and prints out a message using both of them

{- 
main :: IO ()
main = do
    args <- getArgs
    putStrLn ("Hello, " ++ (args !! 0) ++ "," ++ (args !! 1))
-}

-- 2.
-- Change the program so it performs a simple arithmetic operation on the two arguments and prints out the result. You can use read to convert a string to a number, and show to convert a number back into a string. Play around with different operations.

{-
main :: IO ()
main = do
    args <- getArgs
    putStrLn $ show $ ((read $ args !! 0 ) + (read $ args !! 1))

Alternatively:
main :: IO ()
main = do
    args <- getArgs
    print ((read $ args !! 0 ) + (read $ args !! 1))

(read $ args !! 0) can also be written as (read (args !! 0))

-- read: convert a string to a number
-- show: convert a number back into a string
-}

-- 3.
-- getLine is an IO action that reads a line from the console and returns it as a string. Change the program so it prompts for a name, reads the name, and then prints that instead of the command line value

{-
main :: IO ()
main = do
    putStrLn "What's your name?"
    name <- getLine
    putStrLn ("Hey " ++ name )
-} 

-- Need to putStrLn first to prompt for name otherwise the terminal will hang

{-
In command line:  
% ghc -o hello_you --make listing2.hs
% % ./hello_you John -- Only provide argument if getArgs is used, otherwise for getLine no need
-}