{-# OPTIONS_GHC -XFlexibleInstances #-}

module Graphs where

import Data.Maybe
import Data.Text.LAzy as T (pack)

import Data.Graph.Inductive.Graph
import Data.Graph.Inductive.PatriciaTree

import Data.GraphViz
import Data.GraphViz.Printing
import Data.GraphViz.Commands
import Data.GraphViz.Attributes.Complete