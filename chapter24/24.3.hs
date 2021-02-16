module LearnParsers where

import Text.Trifecta 

stop :: Parser a
stop = unexpected "stop"
-- unexpected: a means of throwing errors

-- read a single character '1'
one = char '1'

-- read a single character '1', then die
one' = one >> stop

-- read two characters, '1' and '2'
oneTwo = char '1' >> char '2'

-- read two characters, '1' and '2', then die
oneTwo' = oneTwo >> stop

testParse :: Parser Char -> IO()
testParse p =
    print $ parseString p mempty "123"
-- the p argument is a character parser

pNL s =
    putStrLn ('\n' : s)

main = do
    pNL "stop:"
    testParse stop

    pNL "one:"
    testParse one

    pNL "one':"
    testParse one'

    pNL "oneTwo:"
    testParse oneTwo

    pNL "oneTwo':"
    testParse oneTwo'



-- Exercises: Parsing practice
-- 1.
oneEof = one >> eof
oneTwoEof = oneTwo >> eof

testEof = do 
    pNL "oneEof succeeds in parsing '1':"
    print $ parseString oneEof mempty "1"

    pNL "oneTwoEof succeeds in parsing '12':"
    print $ parseString oneTwoEof mempty "12"

    pNL "oneEof fails in parsing '12':"
    print $ parseString oneEof mempty "12"

-- 2.
testString :: Parser String -> IO()
testString p = print $ parseString p mempty "123"

p123 :: String -> Parser String
p123 n = string n >> stop

testp123 = do
    testString $ p123 "1"
    testString $ p123 "12"
    testString $ p123 "123"
    --testString $ p123 "12345"

-- 3.
testChar :: Parser Char -> IO()
testChar p = print $ parseString p mempty "123"

c123 :: Char -> Parser Char
c123 n = char n  >> stop

testc123 = do 
    testChar $ c123 '1'
    testChar $ c123 '2'
    testChar $ c123 '3'
    --testChar $ c123 '4'