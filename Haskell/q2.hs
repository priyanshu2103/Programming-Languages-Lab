import System.Random (newStdGen)
import System.Random.Shuffle (shuffle')
import Data.IORef ( IORef, newIORef, readIORef, writeIORef )
import System.IO.Unsafe ( unsafePerformIO )

-- list of all the teams taking part in football tournament
teamList :: [[Char]]
teamList = ["BS","CM","CH","CV","CS","DS","EE","HU","MA","ME","PH","ST"]

--Helper function to get name of first team and second team from the tuple (Team1, Team2, Date, Time)
firstTeam :: (a, b, c, d) -> a
firstTeam (team1, _, _, _) = team1
secondTeam :: (a, b, c, d) -> b
secondTeam (_, team2, _, _) = team2

-- Helper function to get the date and time in specified format from the tuple (Team1, Team2, Date, Time)
getDate :: (Eq a1, Num a1) => (a2, b, a1, d) -> [Char]
getDate (_, _, date, _) = do
 if date==1 then
    "1-11"
 else if date == 2 then
    "2-11"
 else
    "3-11"
 
getTime :: (Eq a1, Num a1) => (a2, b, c, a1) -> [Char]
getTime (_, _, _, time) = do
 if time == 0 then
    "9:30 AM"
 else
    "7:30 PM"

printAllMatches :: (Eq c, Eq a1, Num c, Num a1) => [([Char], [Char], c, a1)] -> IO ()
-- base case of recursion
printAllMatches [] = return ()

--recursive function to print all the scheduled matches, extracts the first element from list of tuples and 
--runs recursively on the remaining list
printAllMatches (head:remList) = do
  let first = firstTeam head++ " VS " ++ secondTeam head++ " " ++ getDate head++ " " ++ getTime head
  putStrLn first
  printAllMatches remList

--helper function to print a match based on it's schedule index (0-indexing)
printGivenMatch :: (Eq c, Eq a1, Num c, Num a1) => Int -> [([Char], [Char], c, a1)] -> IO ()
printGivenMatch index fixList = do
 let elem = fixList!!index                      -- extract the indexed element from the list of fixtures
 putStrLn (firstTeam elem++ " VS " ++ secondTeam elem++ " " ++ getDate elem++ " " ++ getTime elem)

printSpecificMatch :: (Eq c, Eq a1, Num c, Num a1) => [Char] -> [([Char], [Char], c, a1)] -> IO ()
-- base case of recursion
printSpecificMatch _ [] = putStrLn "No such team found"

--recursive function which searches the fixture of a team in the list of fixtures by checking the first element,
--if that satisfies, then print or else search recursively on remaining list
printSpecificMatch team (head:remList) = do
  if team == firstTeam head || team == secondTeam head then
    putStrLn (firstTeam head++ " VS " ++ secondTeam head++ " " ++ getDate head++ " " ++ getTime head)
  else
    printSpecificMatch team remList
 

scheduleMatches :: (Eq a1, Num a1, Num a2) => [b] -> Int -> a2 -> a1 -> [(b, b, a2, a1)]
-- base case of recursion
scheduleMatches _ 6 _ _ = []

--recursive function which returns all the scheduled fixtures in the tuple (Team1, Team2, Date, Time)
scheduleMatches teams index day time = do
  let teamFirst = teams!!(index*2)               -- finding the team name according to index
  let teamSecond = teams!!(index*2+1)
  if time == 1 then                                   -- update the index, day and time according to time (takes 0,1 value)
    (teamFirst, teamSecond, day, time):scheduleMatches teams (index+1) (day+1) (1-time)      -- time = 1 is the evening fixture
  else
    (teamFirst, teamSecond, day, time):scheduleMatches teams (index+1) day (1-time)          -- time = 0 is the morning fixture

{-# NOINLINE matches #-}
matches :: IORef [([Char], [Char])]
matches = unsafePerformIO (newIORef [("None", "None")])

{-# NOINLINE getShuffledTeams #-}
getShuffledTeams :: IORef [[Char]]
getShuffledTeams = unsafePerformIO (newIORef teamList)

-- gets the next match that is scheduled after the given date and time by calculating the index number of the match that is next
nextMatch :: (Ord a, Fractional a) => Int -> a -> IO ()
nextMatch date time = do
    checker <- readIORef matches                                                   -- checks if fixtures are generated or not
    teams <- readIORef getShuffledTeams                                            -- gets the fixtures in "teams"
    if time > 24.00 then putStrLn "Enter time between 0.00 and 24.00"
    else if time < 0.00 then putStrLn "Enter time between 0.00 and 24.00"
    else if date < 1 || date >30 then putStrLn "Date should be between 1 and 30"
    else if date >=4 then putStrLn "All matches done"
    else if date == 3 && time > 19.30 then putStrLn "All matches done"
    else do
        if length checker == 1 then
            print "No fixtures generated yet"
        else if time > 19.30 then do
            let matchNum = (date - 1) * 2 + 2
            printGivenMatch matchNum (scheduleMatches teams 0 1 0)    -- index=0, date=1, time=0
        else if time > 9.30 then do
            let matchNum = (date - 1) * 2 + 1
            printGivenMatch matchNum (scheduleMatches teams 0 1 0)
        else do
            let matchNum = (date - 1) * 2
            printGivenMatch matchNum (scheduleMatches teams 0 1 0)

-- schedules the fixtures and prints all the scheduled fixtures
-- evertime this is called, a new fixture schedule is made randomly
fixture :: [Char] -> IO ()
fixture "all" = do
    rng <- newStdGen
    let shuffledList = shuffle' teamList (length teamList) rng
    let pairs = [(shuffledList !! i, shuffledList !! (i+1)) | i <- [0,2..10]]
    writeIORef matches pairs
    writeIORef getShuffledTeams shuffledList
    printAllMatches(scheduleMatches shuffledList 0 1 0)             -- index=0, date=1, time=0

-- prints the fixture of a particular team
fixture teamName = do
    checker <- readIORef matches                        -- checks if the fixtures are scheduled yet or not
    teams <- readIORef getShuffledTeams
    if length checker == 1 then
        putStrLn "No fixtures generated yet"
    else 
        printSpecificMatch teamName (scheduleMatches teams 0 1 0)