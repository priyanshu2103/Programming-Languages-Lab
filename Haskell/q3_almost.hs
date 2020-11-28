import Data.Function ()

isMember :: (Foldable t, Eq a) => a -> t a -> Bool
isMember num list = do
    num `elem` list

delSameTwo :: (Eq a, Num a) => [((a, a), (a, a))] -> [a] -> a -> a -> [((a, a), (a, a))]
delSameTwo [] _ _ _ = []

delSameTwo ((a, b) : xs) list elem1 elem2 = do
    if isMember ((getFirstFromTuple a * getSecondFromTuple a * elem1) + (getFirstFromTuple b * getSecondFromTuple b * elem2)) list then
        delSameTwo xs list elem1 elem2
    else 
        (a, b) : delSameTwo xs (((getFirstFromTuple a * getSecondFromTuple a * elem1) + (getFirstFromTuple b * getSecondFromTuple b *elem2)) : list) elem1 elem2

delSameThree :: (Eq a, Num a) => [((a, a), (a, a), (a, a))] -> [a] -> a -> a -> a -> [((a, a), (a, a), (a, a))]
delSameThree [] _ _ _ _ = []

delSameThree ((a, b, c) : xs) list elem1 elem2 elem3 = do
    if isMember ((getFirstFromTuple a * getSecondFromTuple a * elem1) + (getFirstFromTuple b * getSecondFromTuple b * elem2) + (getFirstFromTuple c * getSecondFromTuple c *elem3)) list then
        delSameThree xs list elem1 elem2 elem3
    else
        (a, b, c) : delSameThree xs (((getFirstFromTuple a * getSecondFromTuple a * elem1)+(getFirstFromTuple b * getSecondFromTuple b * elem2) + (getFirstFromTuple c * getSecondFromTuple c * elem3)):list) elem1 elem2 elem3

delSameFour :: (Eq a, Num a) => [((a, a), (a, a), (a, a), (a, a))] -> [a] -> a -> a -> a -> a -> [((a, a), (a, a), (a, a), (a, a))]
delSameFour [] _ _ _ _ _ = []

delSameFour ((a, b, c, d) : xs) list elem1 elem2 elem3 elem4 = do
    if isMember ((getFirstFromTuple a * getSecondFromTuple a * elem1) + (getFirstFromTuple b * getSecondFromTuple b * elem2) + (getFirstFromTuple c * getSecondFromTuple c * elem3) + (getFirstFromTuple d * getSecondFromTuple d * elem4)) list then
        delSameFour xs list elem1 elem2 elem3 elem4
    else
        (a,b,c,d) : delSameFour xs (((getFirstFromTuple a * getSecondFromTuple a * elem1) + (getFirstFromTuple b * getSecondFromTuple b * elem2) + (getFirstFromTuple c * getSecondFromTuple c * elem3) + (getFirstFromTuple d * getSecondFromTuple d * elem4)) : list) elem1 elem2 elem3 elem4

delSameFive :: (Eq a, Num a) => [((a, a), (a, a), (a, a), (a, a), (a, a))] -> [a] -> a -> a -> a -> a -> a -> [((a, a), (a, a), (a, a), (a, a), (a, a))]
delSameFive [] _ _ _ _ _ _ = []

delSameFive ((a, b, c, d, e) : xs) list elem1 elem2 elem3 elem4 elem5 = do
    if isMember ((getFirstFromTuple(a)*getSecondFromTuple(a)*elem1)+(getFirstFromTuple(b)*getSecondFromTuple(b)*elem2)+(getFirstFromTuple(c)*getSecondFromTuple(c)*elem3)+(getFirstFromTuple(d)*getSecondFromTuple(d)*elem4)+(getFirstFromTuple(e)*getSecondFromTuple(e)*elem5)) list then
        delSameFive xs list elem1 elem2 elem3 elem4 elem5
    else
        (a,b,c,d,e) : delSameFive xs (((getFirstFromTuple(a)*getSecondFromTuple(a)*elem1)+(getFirstFromTuple(b)*getSecondFromTuple(b)*elem2)+(getFirstFromTuple(c)*getSecondFromTuple(c)*elem3)+(getFirstFromTuple(d)*getSecondFromTuple(d)*elem4)+(getFirstFromTuple(e)*getSecondFromTuple(e)*elem5)):list) elem1 elem2 elem3 elem4 elem5

delSameSix :: (Eq a, Num a) => [((a, a), (a, a), (a, a), (a, a), (a, a), (a, a))] -> [a] -> a -> a -> a -> a -> a -> a -> [((a, a), (a, a), (a, a), (a, a), (a, a), (a, a))]
delSameSix [] _ _ _ _ _ _ _ = []

delSameSix ((a,b,c,d,e,f):xs) list2 elem1 elem2 elem3 elem4 elem5 elem6 = do
    if isMember ((getFirstFromTuple(a)*getSecondFromTuple(a)*elem1)+(getFirstFromTuple(b)*getSecondFromTuple(b)*elem2)+(getFirstFromTuple(c)*getSecondFromTuple(c)*elem3)+(getFirstFromTuple(d)*getSecondFromTuple(d)*elem4)+(getFirstFromTuple(e)*getSecondFromTuple(e)*elem5)+(getFirstFromTuple(f)*getSecondFromTuple(f)*elem6)) list2 then
        delSameSix xs list2 elem1 elem2 elem3 elem4 elem5 elem6
    else
        (a,b,c,d,e,f) : delSameSix xs (((getFirstFromTuple(a)*getSecondFromTuple(a)*elem1)+(getFirstFromTuple(b)*getSecondFromTuple(b)*elem2)+(getFirstFromTuple(c)*getSecondFromTuple(c)*elem3)+(getFirstFromTuple(d)*getSecondFromTuple(d)*elem4)+(getFirstFromTuple(e)*getSecondFromTuple(e)*elem5)+(getFirstFromTuple(f)*getSecondFromTuple(f)*elem6)):list2) elem1 elem2 elem3 elem4 elem5 elem6
 
maximumArea :: [((Integer, Integer), (Integer, Integer), (Integer, Integer), (Integer, Integer), (Integer, Integer), (Integer, Integer))] -> Integer -> Integer -> Integer -> Integer -> Integer -> Integer -> Integer
maximumArea [] _ _ _ _ _ _ = 0
maximumArea ((a, b, c, d, e, f) : xs) elem1 elem2 elem3 elem4 elem5 elem6 = maximum [((getFirstFromTuple(a)*getSecondFromTuple(a)*elem1)+(getFirstFromTuple(b)*getSecondFromTuple(b)*elem2)+(getFirstFromTuple(c)*getSecondFromTuple(c)*elem3)+(getFirstFromTuple(d)*getSecondFromTuple(d)*elem4)+(getFirstFromTuple(e)*getSecondFromTuple(e)*elem5)+(getFirstFromTuple(f)*getSecondFromTuple(f)*elem6)):: Integer, maximumArea(xs) elem1 elem2 elem3 elem4 elem5 elem6]

getFirstFromTuple :: (a, b) -> a
getFirstFromTuple (a, _) = a

getSecondFromTuple :: (a, b) -> b
getSecondFromTuple (_, b) = b

retrieveAllDimensions :: (Enum a, Enum b) => (a, b) -> (a, b) -> [(a, b)]
retrieveAllDimensions lowerDim higherDim = [(x, y) | x <- [getFirstFromTuple lowerDim..getFirstFromTuple higherDim], y <- [getSecondFromTuple lowerDim..getSecondFromTuple higherDim]]

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

printAnswer :: (Show a1, Show a2, Show a3, Show a4, Show a5, Show a6, Show a7, Show a8, Show a9, Show a10, Show a11, Show a12, Show a13) => [(a2, a4, a6, a8, a10, a12)] -> a1 -> a3 -> a5 -> a7 -> a9 -> a11 -> a13 -> IO ()
printAnswer answer numBedrooms numHalls numKitchens numBathrooms numGarden numBalcony unusedSpace = do
    if null answer then
        putStrLn "No design possible for the given constraints"
    else do 
        let (dim1, dim2, dim3, dim4, dim5, dim6) = head answer
        putStrLn $ "Bedroom: " ++ show numBedrooms ++ " " ++ show dim1
        putStrLn $ "Hall: " ++ show numHalls ++ " " ++ show dim2
        putStrLn $ "Kitchen: " ++ show numKitchens ++ " " ++ show dim3
        putStrLn $ "Bathroom: " ++ show numBathrooms ++ " " ++ show dim4
        putStrLn $ "Garden: " ++ show numGarden ++ " " ++ show dim5
        putStrLn $ "Balcony: " ++ show numBalcony ++ " " ++ show dim6
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

    let bedroomDims = retrieveAllDimensions minBedroomDim maxBedroomDim
    let hallDims = retrieveAllDimensions minHallDim maxHallDim
    let kitchenDims = retrieveAllDimensions minKitchenDim maxKitchenDim
    let bathroomDims = retrieveAllDimensions minBathroomDim maxBathroomDim
    let balconyDims = retrieveAllDimensions minBalconyDim maxBalconyDim
    let gardenDims = retrieveAllDimensions minGardenDim maxGardenDim

    let numKitchens = ceiling(fromIntegral numBedrooms / 3)
    let numBathrooms = numBedrooms + 1
    let numGarden = 1
    let numBalcony = 1

    -- (bedroomDims, hallDims)
    let posBH = [(elem1, elem2) | (elem1, elem2) <- bedHall bedroomDims hallDims, getFirstFromTuple elem1 * getSecondFromTuple elem1 * numBedrooms + getFirstFromTuple elem2 * getSecondFromTuple elem2 * numHalls <= availableSpace]
    let tempBH = delSameTwo posBH [] numBedrooms numHalls
    
    let posBHK = [(elem1, elem2, elem3) | (elem1, elem2, elem3) <- bedHallKitch tempBH kitchenDims, getFirstFromTuple elem1 * getSecondFromTuple elem1 * numBedrooms + getFirstFromTuple elem2 * getSecondFromTuple elem2 * numHalls + getFirstFromTuple elem3 * getSecondFromTuple elem3 * numKitchens <= availableSpace]
    let tempBHK = delSameThree posBHK [] numBedrooms numHalls numKitchens

    let posBHKB = [(elem1, elem2, elem3, elem4) | (elem1, elem2, elem3, elem4) <- bedHallKitchBath tempBHK bathroomDims, getFirstFromTuple elem1 * getSecondFromTuple elem1 * numBedrooms + getFirstFromTuple elem2 * getSecondFromTuple elem2 * numHalls + getFirstFromTuple elem3 * getSecondFromTuple elem3 * numKitchens + getFirstFromTuple elem4 * getSecondFromTuple elem4 * numBathrooms <= availableSpace]
    let tempBHKB = delSameFour posBHKB []numBedrooms numHalls numKitchens numBathrooms  

    let posBHKBG = [(elem1, elem2, elem3, elem4, elem5) | (elem1, elem2, elem3, elem4, elem5) <- bedHallKitchBathGar tempBHKB gardenDims, getFirstFromTuple elem1 * getSecondFromTuple elem1 * numBedrooms + getFirstFromTuple elem2 * getSecondFromTuple elem2 * numHalls + getFirstFromTuple elem3 * getSecondFromTuple elem3 * numKitchens + getFirstFromTuple elem4 * getSecondFromTuple elem4 * numBathrooms + getFirstFromTuple elem5 * getSecondFromTuple elem5 * numGarden <= availableSpace]
    let tempBHKBG = delSameFive posBHKBG [] numBedrooms numHalls numKitchens numBathrooms numGarden    

    let posBHKBGB = [(elem1, elem2, elem3, elem4, elem5, elem6) | (elem1, elem2, elem3, elem4, elem5, elem6) <- bedHallKitchBathGarBal tempBHKBG balconyDims, getFirstFromTuple elem1 * getSecondFromTuple elem1 * numBedrooms + getFirstFromTuple elem2 * getSecondFromTuple elem2 * numHalls + getFirstFromTuple elem3 * getSecondFromTuple elem3 * numKitchens + getFirstFromTuple elem4 * getSecondFromTuple elem4 * numBathrooms + getFirstFromTuple elem5 * getSecondFromTuple elem5 * numGarden + getFirstFromTuple elem6 * getSecondFromTuple elem6 * numBalcony <= availableSpace]
    let tempBHKBGB = delSameSix posBHKBGB [] numBedrooms numHalls numKitchens numBathrooms numGarden numBalcony   -- remove duplicate areas
    

    -- calculate max availableSpace possible
    let maxArea = maximumArea tempBHKBGB numBedrooms numHalls numKitchens numBathrooms numGarden numBalcony
    -- get the dimensions with maximum availableSpace
    let answer = filter (\(a,b,c,d,e,f) ->                                     
                                ((getFirstFromTuple(a)*getSecondFromTuple(a)*numBedrooms)               
                                + (getFirstFromTuple(b)*getSecondFromTuple(b)*numHalls)                 
                                + (getFirstFromTuple(c)*getSecondFromTuple(c)*numKitchens) 
                                + (getFirstFromTuple(d)*getSecondFromTuple(d)*numBathrooms) 
                                + (getFirstFromTuple(e)*getSecondFromTuple(e)*numGarden)
                                + (getFirstFromTuple(f)*getSecondFromTuple(f)*numBalcony)       
                                == maxArea)) tempBHKBGB

    -- let answer = [(elem1, elem2, elem3, elem4, elem5, elem6) | (elem1, elem2, elem3, elem4, elem5, elem6) <- ]

    let unusedSpace = availableSpace - maxArea
    printAnswer answer numBedrooms numHalls numKitchens numBathrooms numGarden numBalcony unusedSpace