-- print1.hs
module Print1 where

main :: IO () --IO stands for input output; used when result of running a program involves effects beyond evaluating a function or expression.
-- Printing to the screen is an effect, so printing the output of a module must be wrapped in this IO type.
main = putStrLn "hello world!"
