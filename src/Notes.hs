module Notes where

import Prelude hiding (readFile)
import Data.Time.Format (formatTime)
import Data.Time.LocalTime (LocalTime, utcToLocalTime, getCurrentTimeZone)
import Data.Time (getCurrentTime, defaultTimeLocale)
import Control.Applicative (liftA2, liftA)
import System.Directory (doesFileExist, getCurrentDirectory)
import Control.Monad ((>=>))
import System.IO.Strict (readFile)


type Note = String

prependTimeStamp :: LocalTime -> String -> Note
prependTimeStamp localTime note = timestamp <> "\t" <> note
        where timestamp = formatTime defaultTimeLocale "%Y-%m-%d %H:%M" localTime


getCurrentTimeLocalTime :: IO LocalTime
getCurrentTimeLocalTime = liftA2 utcToLocalTime getCurrentTimeZone getCurrentTime


prependCurrentTimeStamp :: String -> IO String
prependCurrentTimeStamp note = liftA prependTimeStamp' getCurrentTimeLocalTime
        where prependTimeStamp' = flip prependTimeStamp $ note


getNotesFile :: IO FilePath
getNotesFile = liftA (\cwd -> cwd <> "/NOTES.txt") getCurrentDirectory 


notesFileExist :: IO Bool
notesFileExist = getNotesFile >>= doesFileExist


getNotes :: IO [Note]
getNotes = do
        exists <- notesFileExist
        if exists
        then liftA lines $ getNotesFile >>= readFile
        else return []


showNotes :: [Note] -> IO ()
showNotes = mapM_ putStrLn

showNotes' :: IO ()
showNotes' = getNotes >>= showNotes


writeNotes :: [Note] -> IO ()
writeNotes notes = getNotesFile >>= (write' . unlines) notes
        where write' = flip writeFile

appendNote :: [Note] -> Note -> [Note]
appendNote notes note = notes <> [note]

addNote :: Note -> IO ()
addNote note = do
    notes <- getNotes
    stampedNote <- prependCurrentTimeStamp note
    (return $ appendNote notes stampedNote) >>= writeNotes

        