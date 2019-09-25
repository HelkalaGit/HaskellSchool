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
   (x:xs) -> x  -- From the course documentation

f5 :: Either Int String -> String
f5 att = case att of 
         Left a -> "Not a string"
         Right b -> b   -- input should be f5 (Right "something")
                        -- or              f5 (Left 5)

f6 :: Either a b -> Maybe b
f6 att = do Right x <- return att
            return x -- Couldnt figure this one out by myself so looked from the                        stackoverflow.com 

--g1 :: Maybe a -> b -> (Either a b)
--g1 a b =  

g2 :: a -> b ->  (a,b)
g2 a b = (a,b) 

--g3 :: a -> b -> Maybe (Either a b)
--g3 a b =  

main :: IO ()
main = undefined
 
-- Just make the functions work like f1.
-- When making changes do :w and on another window be in stack ghci mode
-- and do :r for reload. Then you can do f1 (1,'a',True) for example.
