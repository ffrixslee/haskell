funx = length ( filter (\x -> rem x 3 == 0 ) [1..30] )

myFilter n = filter (\n -> n /= "the" && n /= "a" && n /= "an") $ words n  
