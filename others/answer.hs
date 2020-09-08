import ParserCombinators
import Parsec
--newType Parse a = String->[(a,String)]
--To define a new Parser to pparse through a list of inputs where a is the input and String is the unconsumed inputs


--Use the Parsec library and define Parse grammar
--Call the 'do' and 'return' function to sequentially parse through the list of inputs
expr = do x <- term
          char '+'
          y <- expr
        return (x + y)
        <|> term
term = do x <- factor
          char '*'
          y <- term
        return (x + y)
        <|> factor
factor = do char '('
            x <- expr
            char ')'
        return (x)
        <|> factor

parse expr "(2+2)*6.1"
