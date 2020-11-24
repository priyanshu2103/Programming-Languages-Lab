import Data.Set as Set
    ( Set, union, fromList, difference, intersection, null, toList )

-- checks if set made from the given list is empty or not, uses 'Set.null' method to find empty set
isEmpty :: Ord a => [a] -> Bool
isEmpty list = do
    let set = Set.fromList list
    Set.null set

-- takes union of sets made from both the input lists, uses 'Set.union' method to take union
takeUnion :: Ord a => [a] -> [a] -> Set a
takeUnion list1 list2 = do
    let set1 = Set.fromList list1
    let set2 = Set.fromList list2
    Set.union set1 set2

-- takes intersection of sets made from both the input lists, uses 'Set.intersection' method to take intersection
takeIntersection :: Ord a => [a] -> [a] -> Set a
takeIntersection list1 list2 = do
    let set1 = Set.fromList list1
    let set2 = Set.fromList list2
    Set.intersection set1 set2

-- takes subtraction of sets made from both the input lists, uses 'Set.difference' method to do set1 - set2
subtraction :: Ord a => [a] -> [a] -> Set a
subtraction list1 list2 = do
    let set1 = Set.fromList list1
    let set2 = Set.fromList list2
    Set.difference set1 set2

-- takes addition of sets made from both the input lists
addition :: (Num a, Ord a) => [a] -> [a] -> Set a
addition list1 list2 = set where
    list = [x + y | x <- list1, y <- list2]
    set = Set.fromList list






