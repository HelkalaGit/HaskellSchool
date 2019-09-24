module Main where

f1 :: (Int,Char,Bool) -> Char  
f1 (a,b,c) = b 

f2 :: (a,b,c) -> b
f2 (a,b,c) = b

f3 :: (a,(b,c,d),e) -> c
f3 (a,(b,c,d),e) = case (a,(b,c,d),e) of
                    (_,(_,value,_),_) -> value

f4 :: [a] -> a
f4 lst = case lst of
   (x:xs) -> x

f5 :: Either Int String -> String
f5 att = case att of 
         Left a -> "Not a string"
         Right b -> b   -- input should be f5 (Right "something")

--f6 :: Either a b -> ? b
--g1 :: Maybe a -> b -> ? (Either a b)
--g2 :: a -> b -> ? (a,b)
--g3 :: a -> b -> ? (Either a b)

main :: IO ()
main = undefined
 
-- Just make the functions work like f1.
-- When making changes do :w and on another window be in stack ghci mode
-- and do :r for reload. Then you can do f1 (1,'a',True) for example.
