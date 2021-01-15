{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty

import Data.Monoid(mconcat)

-- imports for concatenating key configurations

import XMonad
import XMonad.Actions.Volume
import Data.Map.Lazy (fromList)
import Data.Monoid (mappend)

-- Templating content in Scotty
main = scotty 3000 $ do
    get "/:word" $ do
        beam <- param "word"
        html
        (mconcat 
          [ "<h1>Scotty, ", beam, "me up!</h1>"])

-- Concatenating connection parameters
runDB :: SqlPersist (ResourceT IO) a
      -> IO a
runDB query = do 
    let connStr = foldr (\(k,v) t ->
                        t <> (encodeUtf8 $
                        k <> "=" <> v " "))
                        "" params
    runResourceT
      . withPostgresqlConn connStr
      $ runSqlConn query

-- Concatenating key configurations
main = do 
    xmonad def { keys = 
        \c -> fromList [
            ((0, xK_F6),
             lowerVolume 4 >> return ()),
             ((0, xK_F7),
             raisVolume 4 >> return ())
        ] `mappend` keys defaultConfig c
        }
        -- the type of keys is a function:
        -- keys :: !(XConfig LAyout
                -- -> Map (ButtonMask, KeySym) (X ()))