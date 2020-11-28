Compile using ghci ./q3.hs
Complete search space is covered

Command: design <area> <no of bedrooms> <no of halls>
Output: design 1000 2 3
        "Bedroom: 2 (10,10)
        Hall: 3 (15,10)
        Kitchen: 1 (7,5)
        Bathroom: 3 (4,5)
        Garden: 1 (11,15)
        Balcony: 1 (9,10)
        Unused Space: 0"

Output within 10s for normal examples. Natually increasing area makes the code run for longer time
I tested it for random various values of area upto 10,000. In no case code ran for more than 2 min on my PC. (100s for an extreme case of design 10000 12 14)

If no design is possible, then output is "No design possible for the given constraints"

Assumptions:    1. No of kitchens is taken to be ceiling(no of bedrooms/3)
                2. Every room of one type will have same dimension (else search space becomes too large to be computationally feasible)