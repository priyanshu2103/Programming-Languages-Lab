To compile do 'ghci q2.hs'

Installations:- I have used 2 different packages that didn't come in my haskell with default installation for
                achieving true randomness

    1. "random" package from https://hackage.haskell.org/package/random. To install "random" I also installed "splitmix"
        from https://hackage.haskell.org/package/splitmix as it was a dependancy.

    2. "random-shuffle" package from https://hackage.haskell.org/package/random-shuffle. To install "random-shuffle", I also
        installed "MonadRandom" from https://hackage.haskell.org/package/MonadRandom as it was a dependancy. Also,
        "MonadRandom" itself had 2 dependencies "primitive" which I installed from https://hackage.haskell.org/package/primitive
        and "transformers-compat" which I installed from https://hackage.haskell.org/package/transformers-compat

I installed these packages in Windows using Cabal package. Installation instructions at 
https://wiki.haskell.org/Cabal/How_to_install_a_Cabal_package

1.  To schedule all the fixtures, the command is fixture "all"
    Ex: fixture "all"
        Output:     MA VS CM 1-11 9:30 AM
                    HU VS ST 1-11 7:30 PM
                    CS VS PH 2-11 9:30 AM
                    BS VS CV 2-11 7:30 PM
                    DS VS ME 3-11 9:30 AM
                    CH VS EE 3-11 7:30 PM

    Every time you call fixture "all", new fixtures would be generated. Every other query would be based on these fixtures.

2.  To find the next fixture of a team, the command is fixture "<team_name>"
    Ex: fixture "DS"
        Output: "DS VS ME 3-11 9:30 AM" 

    If you enter a team that does not exist, the output is "No such team found".
    If you enter this query before generating fixtures(i.e. before fixture "all"), then output is "No fixtures generated yet".

2.  To get the next match after a specified time and date, command is "nextMatch <date> <time>"
    date should be an integer and time(24hr) should be in floats. Ex: 15.21 means 3:21 PM
    Ex: "nextMatch 3 11.31"
        Output: "CH VS EE 3-11 7:30 PM"

    If you enter this query before generating fixtures(i.e. before fixture "all"), then output is "No fixtures generated yet".
    Different cases has been handled when dates and time is given in wrong range.
    If all matches has been scheduled and no new match remains, output is "All matches done"
    


