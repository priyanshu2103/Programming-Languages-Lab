Compile using ghci .\q1.hs

1.  To Check if a set made from a given list is empty of not, write 'isEmpty [1,2,3]'
    Ex: "isEmpty [1,2,3]" returns False
        "isEmpty []" returns True

2.  To check union of sets made from two lists, write 'takeUnion [1,2,3,1] [1,2]'
    Ex: 'takeUnion [1,2,3,1] [1,2]' returns [1,2,3]

3.  To check intersection of sets made from two lists, write 'takeIntersection [1,2,3,1] [1,2]'
    Ex: 'takeIntersection [1,2,3,1] [1,2]' returns [1,2]

4.  To check subtraction of sets made from two lists, write 'subtraction [1,2,3,1] [1,2]'
    Ex: 'subtraction [1,2,3,1] [1,2]' returns [3]

5.  To check addition of sets made from two lists, write 'addition [1,2,3,1] [1,2]'
    Ex: 'addition [1,2,3,1] [1,2]' returns [2,3,4,5]