module LearnParsers where

import Text.Trifecta
import Text.Parser.Combinators
import Control.Applicative ((<|>))

stop :: Parser a
stop = unexpected "stop"

one = char '1'
one' = one >> stop

oneTwo = char '1' >> char '2'
oneTwo' = oneTwo >> stop

testParse :: Parser Char -> IO ()
testParse p =
    print $ parseString p mempty "123"

testEOF :: Parser () -> IO ()
testEOF p =
    print $ parseString p mempty "123"

pNL s = 
    putStrLn ('\n' : s)

main = do
    pNL "stop:"

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
failOne = one >> eof
failOneTwo = oneTwo >> eof

test1 = do
    pNL "failOne succeeds parsing '1':"
    print $ parseString failOne mempty "1"

    pNL "failOneTwo fails parsing '12':"
    print $ parseString failOneTwo mempty "12"
    

--oneTwoThree = (string "123" <|> string "12" <|> string "1") >> eof
-- <|> is a "choice"

oneTwoThree = string "1'" >> string "2" >> string "3"
p123 = oneTwoThree >> eof

test2 = do
    pNL "multString succeeds parsing '1':"
    print $ parseString oneTwoThree mempty "1"

    pNL "multString succeeds parsing '12':"
    print $ parseString oneTwoThree mempty "12"

    pNL "multString succeeds parsing '123':"
    print $ parseString oneTwoThree mempty "123"



