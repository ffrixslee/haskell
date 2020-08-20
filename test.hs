-- Exercise 1
sayHello :: String -> IO ()
sayHello x =
  putStrLn ("Hello, " ++ x ++ "!") -- Name to be inserted between quotation marks in Command Prompt

  -- Here, :: is a way to write down a type signature.

-- Exercise 2

--Ex 2.1
triple x = x * 3
--Ex 2.2
square p = 3.14 * (p * p)
