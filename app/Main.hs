module Main where

import Notes
import System.Environment (getArgs)

main :: IO ()
main = do 
    args <- getArgs
    case args of
        [] -> showNotes'
        _  -> let note = unwords args in addNote note
