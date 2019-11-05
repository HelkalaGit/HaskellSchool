module Main where

-- The plan is to place 8 queens on a chess board in such way
-- that there is no more than one piece in each column, each row and each 
-- diagonal of the board is a common recursive puzzle.

type Queen = (Int,Int)
type Setup = [Int]

addQueen :: Setup -> [Setup]
addQueen qs = [snd new:qs
              | y  <- [1..8]
              , let new = (1 + length qs,y)
              , not (any (threatens new) (zip [1..] qs))
              ]

queens :: Setup -> [Setup]
queens qs | length qs >= 8  = [qs]
          | otherwise       = concat (map queens (addQueen qs))

showBoard :: Setup -> [[Char]] 
showBoard queens = [[mark (x,y) 
                     | x <- [1 .. 8]] 
                     | y <- [1 .. 8]]
 where
  mark pt
   | any (threatens pt) (zip [1..] queens) 
     && pt `elem` (zip [1..] queens)      
    = 'T'  -- A threatened queen
   | pt `elem` (zip [1..] queens)          
    = 'Q'   -- A queen
   | any (threatens pt) (zip [1..] queens) 
    = 'X' -- A threatened square
   | otherwise                 
    = '_'  -- An empty square

allPoss :: [[Int]]
allPoss = [[y]
           | y <- [1..8]
           ]

--mergeSom :: [Int] -> [[Int]] -> [[Int]]
--mergeSom a b = a ++ (b !! 0) : mergeSom a (drop 1 b)

mergeAll :: [[Int]] -> [[Int]] -> [[Int]]
mergeAll [[]] [[]] = [[]]
mergeAll [[]] b = b
mergeAll a [[]] = a 
mergeAll a b = [xs ++ ys | xs <- a, ys <- b] 

merge :: [[Int]] -> [Int] -> [[Int]]
merge [[]] [] = [[]]
merge xs [] = xs
merge [[]] ys = [[]]
merge (x:xs) ys  = ((x++ys):xs)

lol :: [[Int]] -> [[Int]] -> [[Int]]
--lol [[]] [[]] = []
--lol [[]] (x:xs) = x
--lol (x:xs) [[]] = x
lol a b  = undefined  

threatens :: Queen -> Queen -> Bool
threatens (a1,a2) (b1,b2)
   | (a1,a2) == (b1,b2) = False -- Queen doesn't threaten herself
   | a2 == b2           = True  -- On the same row
   | a1 == b1           = True  -- On the same column
   | (a1-a2) == (b1-b2) = True  -- diagonal
   | (a1+a2) == (b1+b2) = True  -- diagonal
   | otherwise = False

main = undefined
