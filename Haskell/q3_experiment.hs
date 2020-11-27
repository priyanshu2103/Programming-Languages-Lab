import Data.Function ()
import Text.Printf ( printf, PrintfArg, PrintfType )

failureCase :: [[Int]]
failureCase = [[-1, -1], [-1, -1], [-1, -1], [-1, -1], [-1, -1], [-1, -1]]

{--
    recursive function which backtracks and finds all the possible orientations
    index here means the following:
    0 -> Bedroom
    1 -> Hall
    2 -> Kitchen
    3 -> Bathroom
    4 -> Balcony
    5 -> Garden
    noOfRooms is a list which stores the required no of rooms
    roomDim is a list which contains the dimensions of the rooms
    maxRoomSize is a list which contains the maximum dimension of a particular room type (by index)
    availableSpace is the space left after allocating a new space for a room

    We go recursively from (x,y) -> (x+1,y) and (x,y) -> (x,y+1). This covers the complete search space
    Assume that dimension of each room of a given type is same, or else search space of solution becomes too large.
    No of kitchens = ceil(No of bedrooms / 3)
--}
checkNthRoom :: [Int] -> [[Int]] -> Int -> [[Int]] -> Int -> [[Int]]
checkNthRoom noOfRooms roomDim availableSpace maxRoomSize index = do
    if index == 0 then do
        -- dimensions of bedroom should not be 0 and should not exceed the maximum dimension given
        if((head (head roomDim)) > maxRoomSize!!index!!0 || ((head roomDim)!!1) > maxRoomSize!!index!!1 || (head (head roomDim)) == 0) then
            failureCase
        else do
            -- check is enough space is there to allocate all rooms
            if getTotalArea noOfRooms roomDim > availableSpace then
                failureCase
            else do
                -- recursive code that increases dimensions by 1 keeping other fixed and checks if it is a better outline
                let temp = index + 1
                let outline1 = checkNthRoom noOfRooms roomDim availableSpace maxRoomSize temp

                if(((roomDim!!index)!!0) < maxRoomSize!!index!!0) then do
                    let outline2 = checkNthRoom noOfRooms ([[(head (head roomDim)) + 1, ((head roomDim)!!1)]] ++ (drop 1 roomDim)) availableSpace maxRoomSize index
                    getBestOutline outline1 outline2 noOfRooms
                else do
                    let outline2 = checkNthRoom noOfRooms ([[(head (head roomDim)), ((head roomDim)!!1) + 1]] ++ (drop 1 roomDim)) availableSpace maxRoomSize index
                    getBestOutline outline1 outline2 noOfRooms
    else if index == 5 then do
        -- dimensions of garden should not exceed the maximum dimension given
        if((head (roomDim!!5)) > maxRoomSize!!index!!0 || ((roomDim!!5)!!1) > maxRoomSize!!index!!1) then
            failureCase
        else do
            -- check is enough space is there to allocate all rooms
            if getTotalArea noOfRooms roomDim > availableSpace then
                failureCase
            else do
                -- recursive code that increases dimensions by 1 keeping other fixed and checks if it is a better outline
                if(((roomDim!!index)!!0) < maxRoomSize!!index!!0) then do
                    let outline = checkNthRoom noOfRooms ((take index roomDim) ++ [[((roomDim!!index)!!0) + 1, ((roomDim!!index)!!1)]]) availableSpace maxRoomSize index
                    getBestOutline roomDim outline noOfRooms
                else do
                    let outline = checkNthRoom noOfRooms ((take index roomDim) ++ [[((roomDim!!index)!!0), ((roomDim!!index)!!1) + 1]]) availableSpace maxRoomSize index
                    getBestOutline roomDim outline noOfRooms
    else do
        if index == 1 then do
            -- dimensions of hall should not exceed the maximum dimension given and it should not be 0
            if(((roomDim!!index)!!0) > maxRoomSize!!index!!0 || ((roomDim!!index)!!1) > maxRoomSize!!index!!1 || ((roomDim!!index)!!0) == 0) then
                failureCase
            else do
                -- check is enough space is there to allocate all rooms
                if getTotalArea noOfRooms roomDim > availableSpace then
                    failureCase
                else do
                    -- recursive code that increases dimensions by 1 keeping other fixed and checks if it is a better outline
                    let temp = index + 1
                    let outline1 = checkNthRoom noOfRooms roomDim availableSpace maxRoomSize temp
                    if(((roomDim!!index)!!0) < maxRoomSize!!index!!0) then do
                        let outline2 = checkNthRoom noOfRooms ((take index roomDim) ++ [[((roomDim!!index)!!0) + 1, ((roomDim!!index)!!1)]] ++ (drop temp roomDim)) availableSpace maxRoomSize index
                        getBestOutline outline1 outline2 noOfRooms
                    else do
                        let outline2 = checkNthRoom noOfRooms ((take index roomDim) ++ [[((roomDim!!index)!!0), ((roomDim!!index)!!1) + 1]] ++ (drop temp roomDim)) availableSpace maxRoomSize index
                        getBestOutline outline1 outline2 noOfRooms
        else if index == 2 then do
            -- dimensions of kitchen should not exceed the maximum dimension given and it should not be 0, further kitchen
            -- should not be bigger than hall or bedroom
            let hallIndex = index - 1
            if(((roomDim!!index)!!0) > maxRoomSize!!index!!0 || ((roomDim!!index)!!1) > maxRoomSize!!index!!1 || ((roomDim!!index)!!0) == 0 || ((roomDim!!index)!!0) > ((roomDim!!hallIndex)!!0) || ((roomDim!!index)!!1) > ((roomDim!!hallIndex)!!1) || ((roomDim!!index)!!0) > ((roomDim!!0)!!0) || ((roomDim!!index)!!1) > ((roomDim!!0)!!1)) then
                failureCase
            else do
                -- check is enough space is there to allocate all rooms
                if getTotalArea noOfRooms roomDim > availableSpace then
                    failureCase
                else do
                    -- recursive code that increases dimensions by 1 keeping other fixed and checks if it is a better outline
                    let temp = index + 1
                    let outline1 = checkNthRoom noOfRooms roomDim availableSpace maxRoomSize temp
                    if(((roomDim!!index)!!0) < maxRoomSize!!index!!0) then do
                        let outline2 = checkNthRoom noOfRooms ((take index roomDim) ++ [[((roomDim!!index)!!0) + 1, ((roomDim!!index)!!1)]] ++ (drop temp roomDim)) availableSpace maxRoomSize index
                        getBestOutline outline1 outline2 noOfRooms
                    else do
                        let outline2 = checkNthRoom noOfRooms ((take index roomDim) ++ [[((roomDim!!index)!!0), ((roomDim!!index)!!1) + 1]] ++ (drop temp roomDim)) availableSpace maxRoomSize index
                        getBestOutline outline1 outline2 noOfRooms
        else if index == 3 then do
            -- dimensions of bathroom should not exceed the maximum dimension given and it should not be 0, further bathroom
            -- should not be bigger than kitchen
            let kitchenIndex = index - 1
            if(((roomDim!!index)!!0) > maxRoomSize!!index!!0 || ((roomDim!!index)!!1) > maxRoomSize!!index!!1 || ((roomDim!!index)!!0) == 0 || ((roomDim!!index)!!0) > ((roomDim!!kitchenIndex)!!0) || ((roomDim!!index)!!1) > ((roomDim!!kitchenIndex)!!1)) then
                failureCase
            else do
                -- check is enough space is there to allocate all rooms
                if getTotalArea noOfRooms roomDim > availableSpace then
                    failureCase
                else do
                    -- recursive code that increases dimensions by 1 keeping other fixed and checks if it is a better outline
                    let temp = index + 1
                    let outline1 = checkNthRoom noOfRooms roomDim availableSpace maxRoomSize temp
                    if(((roomDim!!index)!!0) < maxRoomSize!!index!!0) then do
                        let outline2 = checkNthRoom noOfRooms ((take index roomDim) ++ [[((roomDim!!index)!!0) + 1, ((roomDim!!index)!!1)]] ++ (drop temp roomDim)) availableSpace maxRoomSize index
                        getBestOutline outline1 outline2 noOfRooms
                    else do
                        let outline2 = checkNthRoom noOfRooms ((take index roomDim) ++ [[((roomDim!!index)!!0), ((roomDim!!index)!!1) + 1]] ++ (drop temp roomDim)) availableSpace maxRoomSize index
                        getBestOutline outline1 outline2 noOfRooms
        else do
            -- dimensions of balcony should not exceed the maximum dimension given
            if(((roomDim!!index)!!0) > maxRoomSize!!index!!0 || ((roomDim!!index)!!1) > maxRoomSize!!index!!1) then
                failureCase
            else do
                -- check is enough space is there to allocate all rooms
                if getTotalArea noOfRooms roomDim > availableSpace then
                    failureCase
                else do
                    -- recursive code that increases dimensions by 1 keeping other fixed and checks if it is a better outline
                    let temp = index + 1
                    let outline1 = checkNthRoom noOfRooms roomDim availableSpace maxRoomSize temp
                    if(((roomDim!!index)!!0) < maxRoomSize!!index!!0) then do
                        let outline2 = checkNthRoom noOfRooms ((take index roomDim) ++ [[((roomDim!!index)!!0) + 1, ((roomDim!!index)!!1)]] ++ (drop temp roomDim)) availableSpace maxRoomSize index
                        getBestOutline outline1 outline2 noOfRooms
                    else do
                        let outline2 = checkNthRoom noOfRooms ((take index roomDim) ++ [[((roomDim!!index)!!0), ((roomDim!!index)!!1) + 1]] ++ (drop temp roomDim)) availableSpace maxRoomSize index
                        getBestOutline outline1 outline2 noOfRooms

-- returns the best outline from two given plans. The more area covered by a outline, the better it is
getBestOutline :: (Ord a, Num a) => [[a]] -> [[a]] -> [a] -> [[a]]
getBestOutline outline1 outline2 noOfRooms =
    if getTotalArea noOfRooms outline1 > getTotalArea noOfRooms outline2 then
        outline1
    else
        outline2

-- returns the total space taken by all the rooms according to the list roomDim which contains dimensions of each room type
getTotalArea :: Num a => [a] -> [[a]] -> a
getTotalArea noOfRooms roomDim = do
    let bedroomArea = head noOfRooms * head (head roomDim) * head (head roomDim)
    let hallArea = (noOfRooms!!1) * (head (roomDim!!1)) * ((roomDim!!1)!!1)
    let kitchenArea = (noOfRooms!!2) * (head (roomDim!!2)) * ((roomDim!!2)!!1)
    let bathroomArea = (noOfRooms!!3) * (head (roomDim!!3)) * ((roomDim!!3)!!1)
    let gardenArea = (noOfRooms!!4) * (head (roomDim!!4)) * ((roomDim!!4)!!1)
    let balconyArea = (noOfRooms!!5) * (head (roomDim!!5)) * ((roomDim!!5)!!1)
    bedroomArea + hallArea + kitchenArea + bathroomArea + gardenArea + balconyArea

-- printOutline :: [t1] -> t2 -> t3 -> IO()
-- printOutline result noOfRooms spaceUnused = do
--     printf "Bedroom: %d, Size: (%d X %d)\n" noOfRooms!!0 (result!!0)!!0 (result!!0)!!1
--     printf "Hall: %d, Size: (%d X %d)\n" noOfRooms!!1 (result!!1)!!0 (result!!1)!!1
--     printf "Kitchen: %d, Size: (%d X %d)\n" noOfRooms!!2 (result!!2)!!0 (result!!2)!!1
--     printf "Bathroom: %d, Size: (%d X %d)\n" noOfRooms!!3 (result!!3)!!0 (result!!3)!!1
--     printf "Balcony: %d, Size: (%d X %d)\n" noOfRooms!!4 (result!!4)!!0 (result!!4)!!1
--     printf "Garden: %d, Size: (%d X %d)\n" noOfRooms!!5 (result!!5)!!0 (result!!5)!!1
--     printf "Unused space: %d" spaceUnused

printOutline :: (Show a1, Show a2, Show a3) => [[a2]] -> [a1] -> a3 -> String -> String
printOutline result noOfRooms spaceUnused = showString "Bedroom: (" . shows (noOfRooms!!0) . showString ") ". shows ((result!!0)!!0) . showString "X" .  shows ((result!!0)!!1) . showString "," . showString "Hall: (" . shows (noOfRooms!!1) . showString ") ". shows ((result!!1)!!0) . showString "X" .  shows ((result!!1)!!1) . showString "," . showString "Kitchen: (" . shows (noOfRooms!!2) . showString ") ". shows ((result!!2)!!0) . showString "X" .  shows ((result!!2)!!1) . showString "," . showString "Bathroom: (" . shows (noOfRooms!!3) . showString ") ". shows ((result!!3)!!0) . showString "X" .  shows ((result!!3)!!1) . showString "," . showString "Balcony: (" . shows (noOfRooms!!4) . showString ") ". shows ((result!!4)!!0) . showString "X" .  shows ((result!!4)!!1) . showString "," . showString "Garden: (" . shows (noOfRooms!!5) . showString ") ". shows ((result!!5)!!0) . showString "X" .  shows ((result!!5)!!1) . showString "," . showString "Unused Space:" . shows (spaceUnused)

-- main function
design :: IO ()
design = do
    putStrLn "Enter Space in square feet"
    input1 <- getLine
    putStrLn "Enter No of bedrooms"
    input2 <- getLine
    putStrLn "Enter No of halls"
    input3 <- getLine
    
    let availableSpace = (read input1 :: Int)
    let numBedrooms = (read input2 :: Int)
    let numHalls = (read input3 :: Int)

    -- we want 1 garden, 1 balcony, `no. of bedrooms + 1` bathrooms and ceil(bedrooms/3) kitchens
    let numGarden = 1
    let numBalcony = 1
    let numBathrooms = numBedrooms + 1
    let numKitchens = ceiling (fromIntegral numBedrooms / 3)

    -- list that stores the required no of rooms of each type
    let noOfRooms = [numBedrooms, numHalls, numKitchens, numBathrooms, numGarden, numBalcony]

    -- Minimum possible dimension for each type of the room
    let minBedroomDim = [10, 10]
    let minHallDim = [15, 10]
    let minKitchenDim = [7, 5]
    let minBathroomDim = [4, 5]
    let minBalconyDim = [5, 5]
    let minGardenDim = [10, 10]

    -- Maximum possible dimension for each type of the room
    let maxBedroomDim = [15, 15]
    let maxHallDim = [20, 15]
    let maxKitchenDim = [15, 13]
    let maxBathroomDim = [8, 9]
    let maxBalconyDim = [10, 10]
    let maxGardenDim = [20, 20]

    -- list which stores the minimum dimension of each room, this list gets updated with final room dimensions
    let roomDim = [minBedroomDim, minHallDim, minKitchenDim, minBathroomDim, minBalconyDim, minGardenDim]

    -- list which stores the maximum dimension of each room
    let maxRoomSize = [maxBedroomDim, maxHallDim, maxKitchenDim, maxBathroomDim, maxBalconyDim, maxGardenDim]

    -- returns the most optimal space utilized design
    let answer = checkNthRoom noOfRooms roomDim availableSpace maxRoomSize 0

    -- total space taken
    let spaceUsed = getTotalArea noOfRooms answer

    -- left space
    let spaceUnused = availableSpace - spaceUsed

    -- print answer
    if head (head answer) == -1 then
        putStrLn "No design possible for the given constraints"
    else
        print(printOutline answer noOfRooms spaceUnused [])
        