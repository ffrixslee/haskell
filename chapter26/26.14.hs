import Control.Monad.Trans.Reader (Reader, ReaderT(..), runReader)
import Control.Monad.Trans.State (StateT(..))
import Control.Monad.Trans.Maybe (MaybeT(..))
import Control.Monad.Trans.Class  (lift)
import Control.Monad (guard)
import Data.Functor.Identity (Identity)

-- 1.

rDec :: Num a => Reader a a
rDec = ReaderT $ \r -> return (r - 1)

result1 = fmap (runReader rDec) [1..10]

-- 2.

rDec' :: Num a => Reader a a
rDec' = ReaderT (return . subtract 1)

result1' = fmap (runReader rDec') [1..10]

-- 3.

rShow :: Show a
      => ReaderT a Identity String
rShow = ReaderT $ \r -> return (show r)

result3 = fmap (runReader rShow) [1..10]

-- 4.

rShow' :: Show a
       => ReaderT a Identity String

rShow' = ReaderT $ (return . show)

result3' = fmap (runReader rShow') [1..10]

-- 5.

rPrintAndInc :: (Num a, Show a)
             =>  ReaderT a IO a
rPrintAndInc = ReaderT $ \r -> do 
    putStrLn $ "Hi: " ++ show r
    return (r + 1)

result4 = do
    runReaderT rPrintAndInc 1
    traverse (runReaderT rPrintAndInc) [1..10]

-- 6.
sPrintIncAccum :: (Num a, Show a) => StateT a IO String
sPrintIncAccum = StateT $ \s -> do
  putStrLn $ "Hi: " ++ show s
  return (show s, s + 1)

result5 = do
    runStateT sPrintIncAccum 10
    mapM (runStateT sPrintIncAccum) [1..5]

-- Fix the code:

isValid :: String -> Bool
isValid v = '!' `elem` v

maybeExcite :: MaybeT IO String
maybeExcite = do 
    v <- lift getLine
    guard $ isValid v
    return v

doExcite :: IO ()
doExcite = do
    putStrLn "say something excite!"
    excite <- runMaybeT maybeExcite

    case excite of
        Nothing -> putStrLn "MOAR EXCITE"
        Just e -> 
            putStrLn
              ("Good, was very excite: " ++ e)