isMember :: Eq t => t -> [t] -> Bool
isMember _ [] = False
isMember num (x:xs) = do
    if num == x then True
    else isMember num xs

deleteSameDimsTwo :: (Eq a, Num a) => [((a, a), (a, a))] -> a -> a -> [((a, a), (a, a))]
deleteSameDimsTwo list num1 num2 = delSameTwo list [] num1 num2

delSameTwo :: (Eq a, Num a) => [((a, a), (a, a))] -> [a] -> a -> a -> [((a, a), (a, a))]
delSameTwo [] _ _ _ = []

delSameTwo ((a, b) : xs) list elem1 elem2 = do
    if isMember ((getFirstFromTuple a * getSecondFromTuple a * elem1) + (getFirstFromTuple b * getSecondFromTuple b * elem2)) list then
        delSameTwo xs list elem1 elem2
    else 
        (a, b) : delSameTwo xs (((getFirstFromTuple a * getSecondFromTuple a * elem1) + (getFirstFromTuple b * getSecondFromTuple b *elem2)) : list) elem1 elem2

deleteSameDimsThree :: (Eq a, Num a) => [((a, a), (a, a), (a, a))] -> a -> a -> a -> [((a, a), (a, a), (a, a))]
deleteSameDimsThree list num1 num2 num3 = delSameThree list [] num1 num2 num3

delSameThree :: (Eq a, Num a) => [((a, a), (a, a), (a, a))] -> [a] -> a -> a -> a -> [((a, a), (a, a), (a, a))]
delSameThree [] _ _ _ _= []

delSameThree ((a, b, c) : xs) list elem1 elem2 elem3 = do
    if isMember ((getFirstFromTuple a * getSecondFromTuple a * elem1) + (getFirstFromTuple b * getSecondFromTuple b * elem2) + (getFirstFromTuple c * getSecondFromTuple c *elem3)) list then
        delSameThree xs list elem1 elem2 elem3
    else
        (a, b, c) : delSameThree xs (((getFirstFromTuple a * getSecondFromTuple a * elem1)+(getFirstFromTuple b * getSecondFromTuple b * elem2) + (getFirstFromTuple c * getSecondFromTuple c * elem3)):list) elem1 elem2 elem3

deleteSameDimsFour :: (Eq a, Num a) => [((a, a), (a, a), (a, a), (a, a))] -> a -> a -> a -> a -> [((a, a), (a, a), (a, a), (a, a))]
deleteSameDimsFour list num1 num2 num3 num4 = delSameFour list [] num1 num2 num3 num4

delSameFour :: (Eq a, Num a) => [((a, a), (a, a), (a, a), (a, a))] -> [a] -> a -> a -> a -> a -> [((a, a), (a, a), (a, a), (a, a))]
delSameFour [] _ _ _ _ _= []

delSameFour ((a, b, c, d) : xs) list elem1 elem2 elem3 elem4 = do
    if isMember ((getFirstFromTuple a * getSecondFromTuple a * elem1) + (getFirstFromTuple b * getSecondFromTuple b * elem2) + (getFirstFromTuple c * getSecondFromTuple c * elem3) + (getFirstFromTuple d * getSecondFromTuple d * elem4)) list then
        delSameFour xs list elem1 elem2 elem3 elem4
    else
        (a,b,c,d) : delSameFour xs (((getFirstFromTuple a * getSecondFromTuple a * elem1) + (getFirstFromTuple b * getSecondFromTuple b * elem2) + (getFirstFromTuple c * getSecondFromTuple c * elem3) + (getFirstFromTuple d * getSecondFromTuple d * elem4)) : list) elem1 elem2 elem3 elem4

deleteSameDimsFive :: (Eq a, Num a) => [((a, a), (a, a), (a, a), (a, a), (a, a))] -> a -> a -> a -> a -> a -> [((a, a), (a, a), (a, a), (a, a), (a, a))]
deleteSameDimsFive list num1 num2 num3 num4 num5 = delSameFive list [] num1 num2 num3 num4 num5

delSameFive :: (Eq a, Num a) => [((a, a), (a, a), (a, a), (a, a), (a, a))] -> [a] -> a -> a -> a -> a -> a -> [((a, a), (a, a), (a, a), (a, a), (a, a))]
delSameFive [] _ _ _ _ _ _= []

delSameFive ((a, b, c, d, e) : xs) list elem1 elem2 elem3 elem4 elem5 = do
    if isMember ((getFirstFromTuple(a)*getSecondFromTuple(a)*elem1)+(getFirstFromTuple(b)*getSecondFromTuple(b)*elem2)+(getFirstFromTuple(c)*getSecondFromTuple(c)*elem3)+(getFirstFromTuple(d)*getSecondFromTuple(d)*elem4)+(getFirstFromTuple(e)*getSecondFromTuple(e)*elem5)) list then
        delSameFive xs list elem1 elem2 elem3 elem4 elem5
    else
        (a,b,c,d,e) : delSameFive xs (((getFirstFromTuple(a)*getSecondFromTuple(a)*elem1)+(getFirstFromTuple(b)*getSecondFromTuple(b)*elem2)+(getFirstFromTuple(c)*getSecondFromTuple(c)*elem3)+(getFirstFromTuple(d)*getSecondFromTuple(d)*elem4)+(getFirstFromTuple(e)*getSecondFromTuple(e)*elem5)):list) elem1 elem2 elem3 elem4 elem5

deleteSameDimsSix :: (Eq a, Num a) => [((a, a), (a, a), (a, a), (a, a), (a, a), (a, a))] -> a -> a -> a -> a -> a -> a -> [((a, a), (a, a), (a, a), (a, a), (a, a), (a, a))]
deleteSameDimsSix list num1 num2 num3 num4 num5 num6 = delSameSix list [] num1 num2 num3 num4 num5 num6

delSameSix :: (Eq a, Num a) => [((a, a), (a, a), (a, a), (a, a), (a, a), (a, a))] -> [a] -> a -> a -> a -> a -> a -> a -> [((a, a), (a, a), (a, a), (a, a), (a, a), (a, a))]
delSameSix [] _ _ _ _ _ _ _= []

delSameSix ((a,b,c,d,e,f):xs) list2 elem1 elem2 elem3 elem4 elem5 elem6 = do
    if isMember ((getFirstFromTuple(a)*getSecondFromTuple(a)*elem1)+(getFirstFromTuple(b)*getSecondFromTuple(b)*elem2)+(getFirstFromTuple(c)*getSecondFromTuple(c)*elem3)+(getFirstFromTuple(d)*getSecondFromTuple(d)*elem4)+(getFirstFromTuple(e)*getSecondFromTuple(e)*elem5)+(getFirstFromTuple(f)*getSecondFromTuple(f)*elem6)) list2 then
        delSameSix xs list2 elem1 elem2 elem3 elem4 elem5 elem6
    else
        (a,b,c,d,e,f) : delSameSix xs (((getFirstFromTuple(a)*getSecondFromTuple(a)*elem1)+(getFirstFromTuple(b)*getSecondFromTuple(b)*elem2)+(getFirstFromTuple(c)*getSecondFromTuple(c)*elem3)+(getFirstFromTuple(d)*getSecondFromTuple(d)*elem4)+(getFirstFromTuple(e)*getSecondFromTuple(e)*elem5)+(getFirstFromTuple(f)*getSecondFromTuple(f)*elem6)):list2) elem1 elem2 elem3 elem4 elem5 elem6
 
getMaximumArea :: [((Integer, Integer), (Integer, Integer), (Integer, Integer), (Integer, Integer), (Integer, Integer), (Integer, Integer))] -> Integer -> Integer -> Integer -> Integer -> Integer -> Integer -> Integer
getMaximumArea list num1 num2 num3 num4 num5 num6 = maximumArea list num1 num2 num3 num4 num5 num6

maximumArea :: [((Integer, Integer), (Integer, Integer), (Integer, Integer), (Integer, Integer), (Integer, Integer), (Integer, Integer))] -> Integer -> Integer -> Integer -> Integer -> Integer -> Integer -> Integer
maximumArea [] _ _ _ _ _ _ = 0
maximumArea ((a, b, c, d, e, f) : xs) elem1 elem2 elem3 elem4 elem5 elem6 = maximum [((getFirstFromTuple(a)*getSecondFromTuple(a)*elem1)+(getFirstFromTuple(b)*getSecondFromTuple(b)*elem2)+(getFirstFromTuple(c)*getSecondFromTuple(c)*elem3)+(getFirstFromTuple(d)*getSecondFromTuple(d)*elem4)+(getFirstFromTuple(e)*getSecondFromTuple(e)*elem5)+(getFirstFromTuple(f)*getSecondFromTuple(f)*elem6)):: Integer, maximumArea(xs) elem1 elem2 elem3 elem4 elem5 elem6]


getFirstFromTuple :: (a, b) -> a
getFirstFromTuple (a, _) = a

getSecondFromTuple :: (a, b) -> b
getSecondFromTuple (_, b) = b

-- given smallest and largest dimension, get all possible dimensions 
retrieveAllDimensions :: (Eq a, Eq b, Num b, Num a) => (a, b) -> (a, b) -> [(a, b)]
retrieveAllDimensions lowerDim higherDim = do
    let newDim = (getFirstFromTuple lowerDim + 1, getSecondFromTuple lowerDim)
    if getFirstFromTuple lowerDim == getFirstFromTuple higherDim then
        retrieveAllDimensions2 lowerDim higherDim
    else
        retrieveAllDimensions2 lowerDim higherDim ++ retrieveAllDimensions newDim higherDim

retrieveAllDimensions2 :: (Eq b, Num b) => (a1, b) -> (a2, b) -> [(a1, b)]
retrieveAllDimensions2 lowerDim higherDim = do
    let newDim = (getFirstFromTuple lowerDim, getSecondFromTuple lowerDim + 1)
    if getSecondFromTuple lowerDim == getSecondFromTuple higherDim then
        [lowerDim]
    else
        lowerDim:retrieveAllDimensions2 newDim higherDim

bedHall :: [a] -> [b] -> [(a, b)]
bedHall list1 list2 = [(a, b) | a <- list1, b <- list2]

bedHallKitch :: [(a, b)] -> [c] -> [(a, b, c)]
bedHallKitch list1 list2 = [(a, b, c) | (a,b) <- list1, c <- list2]

bedHallKitchBath :: [(a, b, c)] -> [d] -> [(a, b, c, d)]
bedHallKitchBath list1 list2 = [(a, b, c, d) | (a,b,c) <- list1, d <- list2]

bedHallKitchBathGar :: [(a, b, c, d)] -> [e] -> [(a, b, c, d, e)]
bedHallKitchBathGar list1 list2 = [(a, b, c, d, e) | (a,b,c,d) <- list1, e <- list2]

bedHallKitchBathGarBal :: [(a, b, c, d, e)] -> [f] -> [(a, b, c, d, e, f)]
bedHallKitchBathGarBal list1 list2 = [(a, b, c, d, e, f) | (a,b,c,d,e) <- list1, f <- list2]

--Main function
design :: Integer -> Integer -> Integer -> IO ()
design area numBedrooms numHalls = do

    -- Minimum possible dimension for each type of the room
    let minBedroomDim = (10, 10)
    let minHallDim = (15, 10)
    let minKitchenDim = (7, 5)
    let minBathroomDim = (4, 5)
    let minBalconyDim = (5, 5)
    let minGardenDim = (10, 10)

    -- Maximum possible dimension for each type of the room
    let maxBedroomDim = (15, 15)
    let maxHallDim = (20, 15)
    let maxKitchenDim = (15, 13)
    let maxBathroomDim = (8, 9)
    let maxBalconyDim = (10, 10)
    let maxGardenDim = (20, 20)

    let bedroom = retrieveAllDimensions minBedroomDim maxBedroomDim
    let hall = retrieveAllDimensions minHallDim maxHallDim
    let kitchen = retrieveAllDimensions minKitchenDim maxKitchenDim
    let bathroom = retrieveAllDimensions minBathroomDim maxBathroomDim
    let balcony = retrieveAllDimensions minBalconyDim maxBalconyDim
    let garden = retrieveAllDimensions minGardenDim maxGardenDim

    let numKitchens = ceiling(fromIntegral numBedrooms / 3)
    let numBathrooms = numBedrooms + 1
    let numGarden = 1
    let numBalcony = 1

    -- (bedroom, hall)
    let tempBH = deleteSameDimsTwo (filter (\(a,b) -> ((getFirstFromTuple(a)*getSecondFromTuple(a)*numBedrooms) 
                                + (getFirstFromTuple(b)*getSecondFromTuple(b))*numHalls) <= area) 
                                (bedHall bedroom hall)) numBedrooms numHalls
    
    -- (bedroom, hall, kitchen)
    let tempBHK = deleteSameDimsThree (filter (\(a,b,c) ->                            -- remove duplicate areas
                                (((getFirstFromTuple(a)*getSecondFromTuple(a)*numBedrooms)              -- area occupied by bedroom
                                + (getFirstFromTuple(b)*getSecondFromTuple(b)*numHalls)                 -- area occupied by halls
                                + (getFirstFromTuple(c)*getSecondFromTuple(c)*numKitchens))             -- area occupied by kitchens
                                <= area)                                     -- sum should be less than equal to given area  
                                && (getFirstFromTuple(c) <= getFirstFromTuple(a) && getFirstFromTuple(c) <= getFirstFromTuple(b)     -- length of kitchen must not be larger than that of bedroom and hall
                                && getSecondFromTuple(c) <= getSecondFromTuple(a) && getSecondFromTuple(c) <= getSecondFromTuple(b)))    -- breadth of kitchen must not be larger than that of bedroom and hall 
                                (bedHallKitch tempBH kitchen))                      -- catesian product of dimensions
                                numBedrooms numHalls numKitchens    
    -- (bedroom, hall, kitchen, bathroom)
    let tempBHKB = deleteSameDimsFour (filter (\(a,b,c,d) ->                          -- remove duplicate areas
                                (((getFirstFromTuple(a)*getSecondFromTuple(a)*numBedrooms)              -- area occupied by bedroom             
                                + (getFirstFromTuple(b)*getSecondFromTuple(b)*numHalls)                 -- area occupied by halls
                                + (getFirstFromTuple(c)*getSecondFromTuple(c)*numKitchens)              -- area occupied by kitchens
                                + (getFirstFromTuple(d)*getSecondFromTuple(d)*numBathrooms))            -- area occupied by bathrooms
                                <= area)                                     -- sum should be less than equal to given area  
                                && (getFirstFromTuple(d) <= getFirstFromTuple(c) && getSecondFromTuple(d) <= getSecondFromTuple(c)))   -- dimension of bathroom must not be larger than that of kitchen
                                (bedHallKitchBath tempBHK bathroom))                     -- catesian product of dimensions  
                                numBedrooms numHalls numKitchens numBathrooms  

    -- (bedroom, hall, kitchen, bathroom, garden)
    let tempBHKBG = deleteSameDimsFive (filter (\(a,b,c,d,e) ->                        -- remove duplicate areas
                                (((getFirstFromTuple(a)*getSecondFromTuple(a)*numBedrooms)              -- area occupied by bedroom             
                                + (getFirstFromTuple(b)*getSecondFromTuple(b)*numHalls)                 -- area occupied by halls
                                + (getFirstFromTuple(c)*getSecondFromTuple(c)*numKitchens)              -- area occupied by kitchens
                                + (getFirstFromTuple(d)*getSecondFromTuple(d)*numBathrooms)             -- area occupied by bathrooms
                                + (getFirstFromTuple(e)*getSecondFromTuple(e)*numGarden))              -- area occupied by garden
                                <= area))                                    -- sum should be less than equal to given area  
                                (bedHallKitchBathGar tempBHKB garden))                       -- catesian product of dimensions 
                                numBedrooms numHalls numKitchens numBathrooms numGarden    

    -- (bedroom, hall, kitchen, bathroom, garden, balcony)
    let tempBHKBGB = deleteSameDimsSix (filter (\(a,b,c,d,e,f) -> 
                                (((getFirstFromTuple(a)*getSecondFromTuple(a)*numBedrooms)              -- area occupied by bedroom             
                                + (getFirstFromTuple(b)*getSecondFromTuple(b)*numHalls)                 -- area occupied by halls
                                + (getFirstFromTuple(c)*getSecondFromTuple(c)*numKitchens)              -- area occupied by kitchens
                                + (getFirstFromTuple(d)*getSecondFromTuple(d)*numBathrooms)             -- area occupied by bathrooms
                                + (getFirstFromTuple(e)*getSecondFromTuple(e)*numGarden)               -- area occupied by garden
                                + (getFirstFromTuple(f)*getSecondFromTuple(f)*numBalcony))             -- area occupied by balcony
                                <= area))                                    -- sum should be less than equal to given area  
                                (bedHallKitchBathGarBal tempBHKBG balcony)) numBedrooms numHalls numKitchens numBathrooms numGarden numBalcony   -- remove duplicate areas
    

    -- calculate max area possible
    let maxArea = getMaximumArea tempBHKBGB numBedrooms numHalls numKitchens numBathrooms numGarden numBalcony
    -- get the dimensions with maximum area
    let result = filter (\(a,b,c,d,e,f) ->                                     
                                ((getFirstFromTuple(a)*getSecondFromTuple(a)*numBedrooms)               
                                + (getFirstFromTuple(b)*getSecondFromTuple(b)*numHalls)                 
                                + (getFirstFromTuple(c)*getSecondFromTuple(c)*numKitchens) 
                                + (getFirstFromTuple(d)*getSecondFromTuple(d)*numBathrooms) 
                                + (getFirstFromTuple(e)*getSecondFromTuple(e)*numGarden)
                                + (getFirstFromTuple(f)*getSecondFromTuple(f)*numBalcony)       
                                == maxArea)) tempBHKBGB

    -- print result
    if (length result == 0)
    then putStrLn $ "No design possible for the given constraints"
    else do 
        let (a,b,c,d,e,f) = result !! 0
        putStrLn $ "Bedroom: " ++ show (numBedrooms) ++ " " ++ show a
        putStrLn $ "Hall: " ++ show (numHalls) ++ " " ++ show b
        putStrLn $ "Kitchen: " ++ show (numKitchens) ++ " " ++ show c
        putStrLn $ "Bathroom: " ++ show (numBathrooms) ++ " " ++ show d
        putStrLn $ "Garden: " ++ show (numGarden) ++ " " ++ show e
        putStrLn $ "Balcony: " ++ show (numBalcony) ++ " " ++ show f
        putStrLn $ "Unused Space: " ++ show (area-maxArea)