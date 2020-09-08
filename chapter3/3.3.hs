{- -- print1.hs
module Print1 where

main :: IO() -- IO involves effects beyond evaluating a function or expression (ie. printing to the screen)
main = putStrLn "hello world!"-}

{- -- print2.hs
module Print2 where

main :: IO()

main = do
  putStrLn "Count to four for me:"
  putStr "one,two"
  putStr ", three, and"
  putStrLn " four!" -}

-- print3.hs
module Print3 where

myGreeting :: String
myGreeting = "hello" ++ " world!"

hello :: String
hello = "hello"

world :: String
world = "world!"

main :: IO()
main = do
  putStrLn myGreeting
  putStrLn secondGreeting
  where secondGreeting =
          concat [hello, " ", world]
