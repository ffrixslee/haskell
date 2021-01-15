{-# OPTIONS_GHC -XFlexibleInstances #-}

module Graphs where

import Data.Text.Lazy as T (pack)

import Data.Graph.Inductive.Graph
import Data.Graph.Inductive.PatriciaTree

import Data.GraphViz
import Data.GraphViz.Printing
import Data.GraphViz.Commands
import Data.GraphViz.Attributes.Complete

import Data.Tuple
import Data.Maybe

-- Exercise 1:
-- Labelled graph

smallGrNodes :: [LNode String]
smallGrNodes = [(1, "A"), (2, "B"), (3, "C"), (4, "G")]

smallGrEdges :: [LEdge Int]
smallGrEdges = [(1, 2, 3), (2, 3, 4), (2, 4, 2),
                (3, 4, 5), (4, 3, 5)]

smallGraph :: Gr String Int
smallGraph = mkGraph smallGrNodes smallGrEdges

smallGrDot :: IO FilePath
smallGrDot = runGraphviz
        (graphToDot quickParams smallGraph) Pdf "graph.pdf"

-- No-label graph on p5:

noLabelNodes :: [LNode String]
noLabelNodes = [(1, "A"), (2, "D"), (3, "E"), (4, "B"), (5, "H"), (6, "I"), (7, "G"), (8, "C"), (9, "F"), (10, "J")]

noLabelEdges :: [LEdge String]
noLabelEdges = 
  [(1, 2, "")  , 
   (1, 3, "")  , (1, 4, ""),
   (2, 5, "")  , (3, 5, ""),
   (4, 7, "")  , (4, 8, ""),
   (8, 7, "")  , (8, 9, ""),
   (8, 6, "")  , (3, 6, ""),
   (9, 10, "") , (6, 10, "")]

noLabelGraph :: Gr String String
noLabelGraph = mkGraph noLabelNodes noLabelEdges

noLabelDot :: IO FilePath
noLabelDot = runGraphviz
        (graphToDot quickParams noLabelGraph) Pdf "nolabelgraph.pdf"

-- Exercise 2 (pending):

data EdgeListGraph a = ELG [a] [(a, a)]
  deriving (Eq, Ord, Show, Read)

smallGrELG :: EdgeListGraph String
smallGrELG = 
    ELG ["A", "B", "C", "G"] [("A", "B"), ("B", "C"), ("B", "G"), ("C", "G"), ("G", "C")]

-- Note: the order of arguments is important for it to correctly typecheck
edgeListGraphToGrNodes :: [a] -> [LNode a]
edgeListGraphToGrNodes ls = zip (enumFromTo 0 $ length ls) ls

--Alternatively(but not a good solution): 
--edgeListGraphToGrNodes ls = zip [0..] ls

-- Edge set
-- [("A",0),("B",1),("C",2),("G",3)]
grToEdgeListGraphNodes ls = zip ls (enumFromTo 0 $ length ls) 


-- Edge list: (x, y, "")
grEdgeList x ls = fromJust $ lookup  x ls
   

--mapNodesToEdges :: [(a, a)] -> [LEdge String]

{-
mapNodesToEdges f =
  case f of
    x -> fst tup
    y -> snd tup
  where tup = (x, y, "")
-}

--edgeListGraphToGr :: (Eq a) => EdgeListGraph a -> Gr a String

-- Exercise 3:

data NextFunGraph a = NFG [a] (a -> [a])

smallGrNexts x = case x of
    "A" -> ["B"]
    "B" -> ["C", "G"]
    "C" -> ["G"]
    "G" -> ["C"]
    _   -> []

smallGrNFG = NFG ["A", "B", "C", "G"] smallGrNexts
