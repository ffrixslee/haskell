jsonSwitch :: Parser (a -> a)
jsonSwitch = 
    infoOption $(hgRevStateTh jsonFormat)
    $ long "json"
    <> short 'J'
    <> help 
       "Display JSON version information"

parserInfo :: ParserInfo (a -> a)
parserInfo = 
    info (helper <*> verSwitch <* jsonSwitch)
          fullDesc
-- <* : allows you to sequence actions, discarding the result of the second argument. (useful for when emitting effects, as in doing something with effects and want to discard any value that results)

-- More parsing

parseJSON :: Value -> Parser a
(.:) :: FromJSON a
     => Object
     -> Text
     -> Parser a

-- for JSON
instance FromJSON Payload where 
    parseJSON (Object v) = 
        Payload <$> v .: "from"
                <*> v .: "to"
                <*> v .: "subject"
                <*> v .: "body"
                <*> v .: "offset_seconds"
    parseJSON v = typeMismatch "Payload" v

-- for CSV(comma-separated data) 
instance FromRecord Release where
    parseRecord v
      | V.length v == 5 = Release <$> v .! 0
                                  <*> v .! 1
                                  <*> v .! 2
                                  <*> v .! 3
                                  <*> v .! 4
      | otherwise = mzero

-- the following example uses liftA2 to lift the tuple data constructor over the parseKey and parseValue to give key-value pairings:
-- you can see <*, infix operator for fmap and =<<
instance Deserializeable ShowInfoResp where
    parser = 
        e2err =<< convertPairs
                  . HM.fromList <$> parsePairs
        where
            parsePairs :: Parser [(Text, Text)]
            parsePairs = 
                parsePair `sepBy` endOfLine
                parsePair = 
                    liftA3 (,) parseKey parseValue
                parseKey = 
                    takeTill (==':') <* kvSep
                kvSep = string ":"
                parseValue = takeTill isEndOfLine

