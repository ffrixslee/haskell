module LearnParsers where

import Text.Trifecta hiding (eof)
import Text.Parser.Combinators hiding (unexpected)

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
one'' = one >> eof

oneTwo'' = oneTwo >> eof