import Data.Time.Clock

import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.UUID as UUID
import qualified Data.UUID.V4 as UUIDv4


-- Lifting over IO
offsetCurrentTime :: NominalDiffTime
                  -> IO UTCTime
offsetCurrentTime offset = 
    fmap (addUTCTime (offset * 24 * 3600)) $
      getCurrentTime

-- different example:
textUuid :: IO Text
textUuid = 
    fmap (T.pack . UUID.toString)
         UUIDv4.nextRandom

-- Lifting over web app monads
userAgent :: AppHandler (Maybe UserAgent)
userAgent = 
    (fmap . fmap) userAgent' getRequest

userAgent' :: Request -> Maybe UserAgent
userAgent' req = 
    getHeader "User-Agent" req

-- Need a functor because cannot pattern-match on AppHandler, unlike the Maybe value

type AppHandler = Handler App App
-- It's a convention in this web framework library, snap, to make a type alias for web application type.