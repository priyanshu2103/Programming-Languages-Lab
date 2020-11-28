import Data.Function ()

-- checks if a number is a member of this list
isMember :: (Foldable t, Eq a) => a -> t a -> Bool
isMember num list = num `elem` list

-- removes duplicate areas from all possible areas of bathroom and hall recursively, needed to speed up the code
uniqueBH :: (Eq a, Num a) => [((a, a), (a, a))] -> [a] -> a -> a -> [((a, a), (a, a))]
uniqueBH [] _ _ _ = []
uniqueBH ((a, b) : xs) list elem1 elem2 = do
    if isMember ((getFirstFromTuple a * getSecondFromTuple a * elem1) + (getFirstFromTuple b * getSecondFromTuple b * elem2)) list then
        uniqueBH xs list elem1 elem2
    else 
        (a, b) : uniqueBH xs (((getFirstFromTuple a * getSecondFromTuple a * elem1) + (getFirstFromTuple b * getSecondFromTuple b *elem2)) : list) elem1 elem2

-- removes duplicate areas from all possible areas of bathroom, hall and kitchen recursively, needed to speed up the code
uniqueBHK :: (Eq a, Num a) => [((a, a), (a, a), (a, a))] -> [a] -> a -> a -> a -> [((a, a), (a, a), (a, a))]
uniqueBHK [] _ _ _ _ = []
uniqueBHK ((a, b, c) : xs) list elem1 elem2 elem3 = do
    if isMember ((getFirstFromTuple a * getSecondFromTuple a * elem1) + (getFirstFromTuple b * getSecondFromTuple b * elem2) + (getFirstFromTuple c * getSecondFromTuple c *elem3)) list then
        uniqueBHK xs list elem1 elem2 elem3
    else
        (a, b, c) : uniqueBHK xs (((getFirstFromTuple a * getSecondFromTuple a * elem1)+(getFirstFromTuple b * getSecondFromTuple b * elem2) + (getFirstFromTuple c * getSecondFromTuple c * elem3)):list) elem1 elem2 elem3

-- removes duplicate areas from all possible areas of bathroom, hall, kitchen and bathroom recursively, needed to speed up the code
uniqueBHKB :: (Eq a, Num a) => [((a, a), (a, a), (a, a), (a, a))] -> [a] -> a -> a -> a -> a -> [((a, a), (a, a), (a, a), (a, a))]
uniqueBHKB [] _ _ _ _ _ = []
uniqueBHKB ((a, b, c, d) : xs) list elem1 elem2 elem3 elem4 = do
    if isMember ((getFirstFromTuple a * getSecondFromTuple a * elem1) + (getFirstFromTuple b * getSecondFromTuple b * elem2) + (getFirstFromTuple c * getSecondFromTuple c * elem3) + (getFirstFromTuple d * getSecondFromTuple d * elem4)) list then
        uniqueBHKB xs list elem1 elem2 elem3 elem4
    else
        (a,b,c,d) : uniqueBHKB xs (((getFirstFromTuple a * getSecondFromTuple a * elem1) + (getFirstFromTuple b * getSecondFromTuple b * elem2) + (getFirstFromTuple c * getSecondFromTuple c * elem3) + (getFirstFromTuple d * getSecondFromTuple d * elem4)) : list) elem1 elem2 elem3 elem4

-- removes duplicate areas from all possible areas of bathroom, hall, kitchen, bathroom and garden recursively
-- needed to speed up the code
uniqueBHKBG :: (Eq a, Num a) => [((a, a), (a, a), (a, a), (a, a), (a, a))] -> [a] -> a -> a -> a -> a -> a -> [((a, a), (a, a), (a, a), (a, a), (a, a))]
uniqueBHKBG [] _ _ _ _ _ _ = []
uniqueBHKBG ((a, b, c, d, e) : xs) list elem1 elem2 elem3 elem4 elem5 = do
    if isMember ((getFirstFromTuple(a)*getSecondFromTuple(a)*elem1)+(getFirstFromTuple(b)*getSecondFromTuple(b)*elem2)+(getFirstFromTuple(c)*getSecondFromTuple(c)*elem3)+(getFirstFromTuple(d)*getSecondFromTuple(d)*elem4)+(getFirstFromTuple(e)*getSecondFromTuple(e)*elem5)) list then
        uniqueBHKBG xs list elem1 elem2 elem3 elem4 elem5
    else
        (a,b,c,d,e) : uniqueBHKBG xs (((getFirstFromTuple(a)*getSecondFromTuple(a)*elem1)+(getFirstFromTuple(b)*getSecondFromTuple(b)*elem2)+(getFirstFromTuple(c)*getSecondFromTuple(c)*elem3)+(getFirstFromTuple(d)*getSecondFromTuple(d)*elem4)+(getFirstFromTuple(e)*getSecondFromTuple(e)*elem5)):list) elem1 elem2 elem3 elem4 elem5

-- removes duplicate areas from all possible areas of bathroom, hall, kitchen, bathroom, garden and balcony recursively
-- needed to speed up the code
uniqueBHKBGB :: (Eq a, Num a) => [((a, a), (a, a), (a, a), (a, a), (a, a), (a, a))] -> [a] -> a -> a -> a -> a -> a -> a -> [((a, a), (a, a), (a, a), (a, a), (a, a), (a, a))]
uniqueBHKBGB [] _ _ _ _ _ _ _ = []
uniqueBHKBGB ((a,b,c,d,e,f):xs) list2 elem1 elem2 elem3 elem4 elem5 elem6 = do
    if isMember ((getFirstFromTuple(a)*getSecondFromTuple(a)*elem1)+(getFirstFromTuple(b)*getSecondFromTuple(b)*elem2)+(getFirstFromTuple(c)*getSecondFromTuple(c)*elem3)+(getFirstFromTuple(d)*getSecondFromTuple(d)*elem4)+(getFirstFromTuple(e)*getSecondFromTuple(e)*elem5)+(getFirstFromTuple(f)*getSecondFromTuple(f)*elem6)) list2 then
        uniqueBHKBGB xs list2 elem1 elem2 elem3 elem4 elem5 elem6
    else
        (a,b,c,d,e,f) : uniqueBHKBGB xs (((getFirstFromTuple(a)*getSecondFromTuple(a)*elem1)+(getFirstFromTuple(b)*getSecondFromTuple(b)*elem2)+(getFirstFromTuple(c)*getSecondFromTuple(c)*elem3)+(getFirstFromTuple(d)*getSecondFromTuple(d)*elem4)+(getFirstFromTuple(e)*getSecondFromTuple(e)*elem5)+(getFirstFromTuple(f)*getSecondFromTuple(f)*elem6)):list2) elem1 elem2 elem3 elem4 elem5 elem6

-- returns the maximum area possible of all the different outlines present 
maximumArea :: [((Integer, Integer), (Integer, Integer), (Integer, Integer), (Integer, Integer), (Integer, Integer), (Integer, Integer))] -> Integer -> Integer -> Integer -> Integer -> Integer -> Integer -> Integer
maximumArea [] _ _ _ _ _ _ = 0
maximumArea ((a, b, c, d, e, f) : xs) elem1 elem2 elem3 elem4 elem5 elem6 = maximum [((getFirstFromTuple(a)*getSecondFromTuple(a)*elem1)+(getFirstFromTuple(b)*getSecondFromTuple(b)*elem2)+(getFirstFromTuple(c)*getSecondFromTuple(c)*elem3)+(getFirstFromTuple(d)*getSecondFromTuple(d)*elem4)+(getFirstFromTuple(e)*getSecondFromTuple(e)*elem5)+(getFirstFromTuple(f)*getSecondFromTuple(f)*elem6)):: Integer, maximumArea(xs) elem1 elem2 elem3 elem4 elem5 elem6]

-- returns the first element from a tuple
getFirstFromTuple :: (a, b) -> a
getFirstFromTuple (a, _) = a

-- returns the second element from a tuple
getSecondFromTuple :: (a, b) -> b
getSecondFromTuple (_, b) = b

-- get all the possible points in the 2D space between two points (point1 and point2)
retrieveAllDimensions :: (Enum a, Enum b) => (a, b) -> (a, b) -> [(a, b)]
retrieveAllDimensions point1 point2 = [(x, y) | x <- [getFirstFromTuple point1..getFirstFromTuple point2], y <- [getSecondFromTuple point1..getSecondFromTuple point2]]

-- makes all possible pairs of bedroom and hall points from the list of bedroom and hall points
bedHall :: [a] -> [b] -> [(a, b)]
bedHall list1 list2 = [(a, b) | a <- list1, b <- list2]

-- makes all possible pairs of bedroom, hall, kitchen points from the list of bedroom, hall and kitchen points
bedHallKitch :: [(a, b)] -> [c] -> [(a, b, c)]
bedHallKitch list1 list2 = [(a, b, c) | (a,b) <- list1, c <- list2]

-- makes all possible pairs of bedroom, hall, kitchen, bathroom points from the list of bedroom, hall, kitchen, bathroom points
bedHallKitchBath :: [(a, b, c)] -> [d] -> [(a, b, c, d)]
bedHallKitchBath list1 list2 = [(a, b, c, d) | (a,b,c) <- list1, d <- list2]

-- makes all possible pairs of bedroom, hall, kitchen, bathroom, garden points
-- from the list of bedroom, hall, kitchen, bathroom and garden points
bedHallKitchBathGar :: [(a, b, c, d)] -> [e] -> [(a, b, c, d, e)]
bedHallKitchBathGar list1 list2 = [(a, b, c, d, e) | (a,b,c,d) <- list1, e <- list2]

-- makes all possible pairs of bedroom, hall, kitchen, bathroom, garden and balcony points
-- from the list of bedroom, hall, kitchen, bathroom, garden and balcony points
bedHallKitchBathGarBal :: [(a, b, c, d, e)] -> [f] -> [(a, b, c, d, e, f)]
bedHallKitchBathGarBal list1 list2 = [(a, b, c, d, e, f) | (a,b,c,d,e) <- list1, f <- list2]

-- prints the final answer in the required format
printAnswer :: (Show a1, Show a2, Show a3, Show a4, Show a5, Show a6, Show a7, Show a8, Show a9, Show a10, Show a11, Show a12, Show a13) => [(a2, a4, a6, a8, a10, a12)] -> a1 -> a3 -> a5 -> a7 -> a9 -> a11 -> a13 -> IO ()
printAnswer answer numBedrooms numHalls numKitchens numBathrooms numGarden numBalcony unusedSpace = do
    if null answer then
        putStrLn "No design possible for the given constraints"
    else do 
        let (dim1, dim2, dim3, dim4, dim5, dim6) = head answer
        putStrLn $ "No of Bedrooms: " ++ show numBedrooms ++ ", Size: " ++ show dim1
        putStrLn $ "No of Halls: " ++ show numHalls ++ ", Size: " ++ show dim2
        putStrLn $ "No of Kitchens: " ++ show numKitchens ++ ", Size: " ++ show dim3
        putStrLn $ "No of Bathrooms: " ++ show numBathrooms ++ ", Size: " ++ show dim4
        putStrLn $ "No of Gardens: " ++ show numGarden ++ ", Size: " ++ show dim5
        putStrLn $ "No of Balconies: " ++ show numBalcony ++ ", Size: " ++ show dim6
        putStrLn $ "Unused Space: " ++ show unusedSpace

--Main function
design :: Integer -> Integer -> Integer -> IO ()
design availableSpace numBedrooms numHalls = do

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

    let bedroomDims = retrieveAllDimensions minBedroomDim maxBedroomDim         -- stores all possible bedroom dimensions
    let hallDims = retrieveAllDimensions minHallDim maxHallDim                  -- stores all possible hall dimensions
    let kitchenDims = retrieveAllDimensions minKitchenDim maxKitchenDim         -- stores all possible kitchen dimensions
    let bathroomDims = retrieveAllDimensions minBathroomDim maxBathroomDim      -- stores all possible bathroom dimensions    
    let balconyDims = retrieveAllDimensions minBalconyDim maxBalconyDim         -- stores all possible balcony dimensions
    let gardenDims = retrieveAllDimensions minGardenDim maxGardenDim            -- stores all possible garden dimensions

    -- number of different rooms according to the problem constraints
    let numKitchens = ceiling(fromIntegral numBedrooms / 3)     
    let numBathrooms = numBedrooms + 1
    let numGarden = 1
    let numBalcony = 1

    {--
       set of functions to find all possible unique combinations of various dimensions.
       iteratively going through all the different types of rooms with the condition that the total area occupied
       by a particular orientation should be less than maximum area. unique_ function is used to remove duplicate areas
       from the list, which speeds up the code and reduces search space. We didn't remove duplicates in bedroom and hall
       because rest rooms have dependencies on them.
    --}
    -- for bedroom and hall
    let posBH = [(elem1, elem2) | (elem1, elem2) <- bedHall bedroomDims hallDims, getFirstFromTuple elem1 * getSecondFromTuple elem1 * numBedrooms + getFirstFromTuple elem2 * getSecondFromTuple elem2 * numHalls <= availableSpace]
    
    -- for bedroom, hall and kitchen
    let posBHK = [(elem1, elem2, elem3) | (elem1, elem2, elem3) <- bedHallKitch posBH kitchenDims, getFirstFromTuple elem1 * getSecondFromTuple elem1 * numBedrooms + getFirstFromTuple elem2 * getSecondFromTuple elem2 * numHalls + getFirstFromTuple elem3 * getSecondFromTuple elem3 * numKitchens <= availableSpace]

    -- for bedroom, hall, kitchen and bathroom
    let posBHKB = [(elem1, elem2, elem3, elem4) | (elem1, elem2, elem3, elem4) <- bedHallKitchBath posBHK bathroomDims, getFirstFromTuple elem1 * getSecondFromTuple elem1 * numBedrooms + getFirstFromTuple elem2 * getSecondFromTuple elem2 * numHalls + getFirstFromTuple elem3 * getSecondFromTuple elem3 * numKitchens + getFirstFromTuple elem4 * getSecondFromTuple elem4 * numBathrooms <= availableSpace]
    let tempBHKB = uniqueBHKB posBHKB [] numBedrooms numHalls numKitchens numBathrooms  

    -- for bedroom, hall, kitchen, bathroom and garden
    let posBHKBG = [(elem1, elem2, elem3, elem4, elem5) | (elem1, elem2, elem3, elem4, elem5) <- bedHallKitchBathGar tempBHKB gardenDims, getFirstFromTuple elem1 * getSecondFromTuple elem1 * numBedrooms + getFirstFromTuple elem2 * getSecondFromTuple elem2 * numHalls + getFirstFromTuple elem3 * getSecondFromTuple elem3 * numKitchens + getFirstFromTuple elem4 * getSecondFromTuple elem4 * numBathrooms + getFirstFromTuple elem5 * getSecondFromTuple elem5 * numGarden <= availableSpace]
    let tempBHKBG = uniqueBHKBG posBHKBG [] numBedrooms numHalls numKitchens numBathrooms numGarden    

    -- for bedroom, hall, kitchen, bathroom, garden and balcony
    let posBHKBGB = [(elem1, elem2, elem3, elem4, elem5, elem6) | (elem1, elem2, elem3, elem4, elem5, elem6) <- bedHallKitchBathGarBal tempBHKBG balconyDims, getFirstFromTuple elem1 * getSecondFromTuple elem1 * numBedrooms + getFirstFromTuple elem2 * getSecondFromTuple elem2 * numHalls + getFirstFromTuple elem3 * getSecondFromTuple elem3 * numKitchens + getFirstFromTuple elem4 * getSecondFromTuple elem4 * numBathrooms + getFirstFromTuple elem5 * getSecondFromTuple elem5 * numGarden + getFirstFromTuple elem6 * getSecondFromTuple elem6 * numBalcony <= availableSpace]
    let tempBHKBGB = uniqueBHKBGB posBHKBGB [] numBedrooms numHalls numKitchens numBathrooms numGarden numBalcony 
    
    -- calculate max area covered among all the possible orientations
    let maxArea = maximumArea tempBHKBGB numBedrooms numHalls numKitchens numBathrooms numGarden numBalcony
    
    -- extracts the dimensions 6-tuple with the maximum area
    let answer = [(elem1, elem2, elem3, elem4, elem5, elem6) | (elem1, elem2, elem3, elem4, elem5, elem6) <- tempBHKBGB, ((getFirstFromTuple(elem1)*getSecondFromTuple(elem1)*numBedrooms) + (getFirstFromTuple(elem2)*getSecondFromTuple(elem2)*numHalls) + (getFirstFromTuple(elem3)*getSecondFromTuple(elem3)*numKitchens) + (getFirstFromTuple(elem4)*getSecondFromTuple(elem4)*numBathrooms) + (getFirstFromTuple(elem5)*getSecondFromTuple(elem5)*numGarden) + (getFirstFromTuple(elem6)*getSecondFromTuple(elem6)*numBalcony) == maxArea)]

    -- space left unutilized
    let unusedSpace = availableSpace - maxArea

    -- prints the best plan of the house
    printAnswer answer numBedrooms numHalls numKitchens numBathrooms numGarden numBalcony unusedSpace