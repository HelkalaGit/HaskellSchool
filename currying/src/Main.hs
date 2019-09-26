module MyCurry where

rectangleArea :: (Double,Double) -> Double
rectangleArea (width,height) = ((\width -> (\height -> width * height))width)height
rectangleArea1 :: Double -> Double -> Double
rectangleArea1 width height = ((\width -> (\height -> width * height))width)height

curry1 :: ((a,b) -> c) -> a -> b -> c
curry1 f a b = f (a,b) 

uncurry1 :: (a -> b -> c) -> ((a,b) -> c)
uncurry1 f (a,b) = f a b 

main :: IO ()
main = undefined
