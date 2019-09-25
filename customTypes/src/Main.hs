module Main where

newtype Meter = M Double 
    deriving (Eq,Ord,Show)

type Length = Int

data Vector2 a = V2 a a 
    deriving (Eq,Show)

data OneOrTwo a b = This a | That b | These a b
    deriving (Eq,Show)

data Submission 
  = S {student :: String, content :: String, date :: (Int,Int,Int)}
    deriving (Eq,Show)


asMeters :: Double -> Meter
asMeters a = (M a)

fromMeters :: Meter -> Double
fromMeters a = case a of
               M value -> value

asLength :: Int -> Length
asLength a = a

mkVector :: Int -> Int -> Vector2 Int
mkVector a b = (V2 a b)  

--combine :: Vector2 Int -> Maybe (Vector2 Int) -> OneOrTwo Int Bool
--combine (V2 a) (V2 b) = 

--combine3 :: Vector2 Int -> Maybe Bool -> Maybe String 
--             -> OneOrTwo Int (OneOrTwo Bool String)

person :: Submission
person = S {student = "Joel",content = "Haskell", date = (11,11,2019)}
-- Get persons data like: date person

fst3 :: (a,b,c) -> a
fst3 (x,_,_) = x -- checked this from stackoverflow

submitDay :: Submission -> Int
submitDay person =
 let
  day = fst3 (date person)
 in day 

--getOther :: OneOrTwo a b -> Maybe b 
--getOther 

main :: IO ()
main = undefined
 
