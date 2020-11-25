module RollsToGetTwenty where

import System.Random

data Die = DieOne
         | DieTwo
         | DieThree
         | DieFour
         | DieFive
         | DieSix
         deriving (Eq, Show)

intToDie :: Int -> Die
intToDie n = case n of
               1 -> DieOne
               2 -> DieTwo
               3 -> DieThree
               4 -> DieFour
               5 -> DieFive
               6 -> DieSix
               x -> error "intToDie got non 1-6 integer"
               
rollsToGetTwenty :: StdGen -> Int
rollsToGetTwenty g = go 0 0 g
  where 
    go :: Int -> Int -> StdGen -> Int
    go sum count gen
      | sum >= 20 = count
      | otherwise = 
          let (die, nextGen) =
                randomR (1, 6) gen
              in go (sum + die)
                    (count + 1) nextGen
-- 1.

rollsToGetN :: Int -> StdGen -> Int
rollsToGetN n g = rolls 0 0 g
  where 
      rolls :: Int -> Int -> StdGen -> Int
      rolls dsum count gen
        | dsum >=n = count
        | otherwise = let (die, nextGen) = randomR (1, 6) gen
        in rolls (dsum + die) (count + 1) nextGen

-- 2.

rollsCountLogged :: Int -> StdGen -> (Int, [Die])
rollsCountLogged n g = (length dice, dice)
  where dice = map intToDie (rolls 0 0 g)
        rolls :: Int -> Int -> StdGen -> [Int]
        rolls dsum count gen
          | dsum >=n = []
          | otherwise = let (die, nextGen) = randomR (1, 6) gen
          in die : (rolls (dsum + die) (count + 1) nextGen)