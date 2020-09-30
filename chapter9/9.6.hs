{-
module MyWords where
myWords :: String -> [String]
myWords [] = [] 
myWords (' ':xs) = myWords xs
myWords xs = fstWord : myWords otherWords 
    where fstWord = takeWhile (/=' ') xs
          otherWords = dropWhile (/=' ') xs
-}
{-
    myWords n a = takeWhile (/="") [n]

-}

module PoemLines where
firstSen = "Tyger Tyger, burning bright\n"
secondSen = "In the forests of the night\n"
thirdSen = "What immortal hand or eye\n"
fourthSen = "Could frame thy fearful\
\ symmetry?"
sentences = firstSen ++ secondSen
         ++ thirdSen ++ fourthSen

myLines :: String -> [String]
myLines [] = []
myLines ('\n': lines) = myLines lines
myLines lines = firstLine : myLines nextLines
 where firstLine = takeWhile (/= '\n') lines
       nextLines = dropWhile (/= '\n') lines

shouldEqual =
    [ "Tyger Tyger, burning bright"
    , "In the forests of the night"
    , "What immortal hand or eye"
    , "Could frame thy fearful symmetry?"
    ]

main :: IO ()
main =
    print $
    "Are they equal? " 
    ++ show (myLines sentences
    == shouldEqual)