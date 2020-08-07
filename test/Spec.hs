
import Test.Hspec
import Data.Time.LocalTime
import Data.Time.Calendar (fromGregorian)

import Notes


{--  US #1
Invoking NOTES without commandline arguments displays the current contents
 of the local NOTES.TXT if it exists.

     TODO print contents of NOTES.TXT verbatim to console.
--}

{-- US #2
If NOTES has arguments, the current date and time are appended to the
 local NOTES.TXT followed by a newline. Then all the arguments, 
 joined with spaces, prepended with a tab, and appended with a trailing 
 newline, are written to NOTES.TXT. If NOTES.TXT doesn't already exist 
 in the current directory then a new NOTES.TXT file should be created. 

     TODO getCurrent DateTime
     TODO appendNoteToFile
--}


main :: IO ()
main = hspec $ do
    describe "Notes" $ do
        it "prependTimeStamp" $
            let Just tod = makeTimeOfDayValid 13 37 0
                doy      = fromGregorian 2020 11 27
                ts       = LocalTime doy tod
            in prependTimeStamp ts "foobar" `shouldBe` "2020-11-27 13:37\tfoobar"

                    
            
