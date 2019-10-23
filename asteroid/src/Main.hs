{-#OPTIONS_GHC -fwarn-incomplete-patterns #-}

module Main where
import Debug.Trace
import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Graphics.Gloss.Interface.Pure.Simulate
import Graphics.Gloss.Interface.Pure.Display

data AsteroidWorld = Play [Rock] Ship [Bullet] [Ufo]
                   | GameOver 
                   deriving (Eq,Show)

type Velocity     = (Float, Float)
type Size         = Float
type Age          = Float
type Health       = Float

--newtype Hunt = Hunt Size Velocity Health
--              deriving (Eq,Show)
--newtype Flee = Flee Size Velocity Health
--              deriving (Eq,Show)
--newtype Explode = Explode Size
--              deriving (Eq,Show)

-- These types should contain atleast some sort of data, for example hp
-- Possibly also color and size

data UfoState     = Hunt Size Velocity Health 
                  | Flee Size Velocity Health
                  | Explode Size
                   deriving (Eq,Show)


data Ship   = Ship   PointInSpace Velocity      
    deriving (Eq,Show)
data Bullet = Bullet PointInSpace Velocity Age  
    deriving (Eq,Show)
data Rock   = Rock   PointInSpace Size Velocity 
    deriving (Eq,Show)
data Ufo    = Ufo    PointInSpace UfoState
    deriving (Eq,Show)

--data Ufo    = Ufo    PointInSpace Size Velocity Health UfoState 
--    deriving (Eq,Show)

huntMode    = Hunt 50 (5,10) 3
fleeMode    = Flee 30 (20,40) 2
explodeMode = Explode 70

-- mode for ufoStates

initialWorld :: AsteroidWorld
initialWorld = Play
                   [Rock (150,150)  45 (2,6)    
                   ,Rock (-45,201)  45 (13,-8) 
                   ,Rock (45,22)    25 (-2,8)  
                   ,Rock (-210,-15) 30 (-2,-8) 
                   ,Rock (-45,-201) 25 (8,2)   
                   ] -- The default rocks
                   (Ship (0,0) (0,5)) -- The initial ship
                   [] -- The initial bullets (none)
                   [Ufo (100,120) huntMode
                   ,Ufo (-100,150) huntMode]
                    -- The Ufos


simulateWorld :: Float -> (AsteroidWorld -> AsteroidWorld)

simulateWorld _        GameOver          = GameOver  

simulateWorld timeStep (Play rocks (Ship shipPos shipV) bullets ufos) 
  | any (collidesWithRock shipPos) rocks = GameOver
  | any (collidesWithUfo shipPos) ufos = GameOver
  | otherwise = Play (concatMap updateRock rocks) 
                              (Ship newShipPos shipV)
                              (concat (map updateBullet bullets))
                              (concatMap updateUfo ufos) -- Ufo simulation
  where
      ufoSize t = case t of 
       Hunt s _ _ -> s
       Flee s _ _ -> s
       Explode s  -> s

      collidesWithRock :: PointInSpace -> Rock -> Bool
      collidesWithRock p (Rock rp s _) 
       = magV (rp .- p) < s

      collidesWithUfo :: PointInSpace -> Ufo -> Bool
      collidesWithUfo p (Ufo up t) 
       = magV (up .- p) < ufoSize(t)  -- returns a boolean based on hit

      collidesWithBulletRock :: Rock -> Bool
      collidesWithBulletRock r 
       = any (\(Bullet bp _ _) -> collidesWithRock bp r) bullets 
    
      collidesWithBulletUfo :: Ufo -> Bool
      collidesWithBulletUfo r
       = any (\(Bullet bp _ _) -> collidesWithUfo bp r) bullets -- returns boolean based on if bullet                                                                   hit ufo
 
      updateRock :: Rock -> [Rock]
      updateRock r@(Rock p s v) 
       | collidesWithBulletRock r && s < 7 
            = []
       | collidesWithBulletRock r && s > 7 
            = splitRock r
       | otherwise                     
            = [Rock (restoreToScreen (p .+ timeStep .* v)) s v]
 
      updateBullet :: Bullet -> [Bullet] 
      updateBullet (Bullet p v a) 
        | a > 5                      
             = []
        | any (collidesWithRock p) rocks 
             = [] 
        | any (collidesWithUfo p) ufos
             = []
        | otherwise                  
             = [Bullet (restoreToScreen (p .+ timeStep .* v)) v 
                       (a + timeStep)] 

      updateUfo :: Ufo -> [Ufo]
      updateUfo r@(Ufo p (Explode _)) = []

      updateUfo r@(Ufo p (Hunt _ v h))  
        | collidesWithBulletUfo r && h > 0
             = reduceHpUfo r
        | otherwise
            = traceShow h [Ufo (restoreToScreen (p .+ timeStep .* v)) huntMode] -- Ufo update
        
      updateUfo r@(Ufo p (Flee _ v h))  
        | collidesWithBulletUfo r && h > 0
            = reduceHpUfo r 
        | otherwise
            = traceShow h [Ufo (restoreToScreen (p .+ timeStep .* v)) fleeMode]
 
      newShipPos :: PointInSpace
      newShipPos = restoreToScreen (shipPos .+ timeStep .* shipV)

splitRock :: Rock -> [Rock]
splitRock (Rock p s v) = [Rock p (s/2) (3 .* rotateV (pi/3)  v)
                         ,Rock p (s/2) (3 .* rotateV (-pi/3) v) ]

reduceHpUfo :: Ufo -> [Ufo]
 
reduceHpUfo (Ufo p (Flee s v h)) = [Ufo p explodeMode]
reduceHpUfo (Ufo p (Hunt s v h)) = [Ufo p fleeMode]

restoreToScreen :: PointInSpace -> PointInSpace
restoreToScreen (x,y) = (cycleCoordinates x, cycleCoordinates y)

cycleCoordinates :: (Ord a, Num a) => a -> a
cycleCoordinates x 
    | x < (-400) = 800+x
    | x > 400    = x-800
    | otherwise  = x

drawWorld :: AsteroidWorld -> Picture

drawWorld GameOver 
   = scale 0.3 0.3 
     . translate (-400) 0 
     . color red 
     . text 
     $ "Game Over!"
     

drawWorld (Play rocks (Ship (x,y) (vx,vy)) bullets ufos)
  = pictures [ship, asteroids, shots, ufo]
   where 
    ufoColor h = case h of 
      Hunt _ _ _ -> yellow
      Flee _ _ _ -> green
      Explode _ -> red
    ufoSize s  = case s of
      Hunt s _ _ -> s
      Flee s _ _ -> s
      Explode s  -> s

    ship      = color red (pictures [translate x y (circle 10)])
    asteroids = pictures [translate x y (color orange (circleSolid s)) 
                         | Rock   (x,y) s _  <- rocks]
    shots     = pictures [translate x y (color red (circle 2)) 
                         | Bullet (x,y) _ _  <- bullets]
    ufo       = pictures [translate x y (color (ufoColor huntMode) (circleSolid (ufoSize huntMode)))
                         | Ufo    (x,y) huntMode <- ufos] -- draw Ufo

handleEvents :: Event -> AsteroidWorld -> AsteroidWorld

handleEvents (EventKey (MouseButton LeftButton) Down _ clickPos) GameOver = initialWorld

handleEvents (EventKey (MouseButton LeftButton) Down _ clickPos)
             (Play rocks (Ship shipPos shipVel) bullets ufos)
             = Play rocks (Ship shipPos newVel) 
                          (newBullet : bullets)
                          ufos -- Ufo attribute for events
 where 
     newBullet = Bullet shipPos 
                        (negate 150 .* norm (shipPos .- clickPos)) 
                        0
     newVel    = shipVel .+ (50 .* norm (shipPos .- clickPos))

handleEvents _ w = w


type PointInSpace = (Float, Float)
(.-) , (.+) :: PointInSpace -> PointInSpace -> PointInSpace
(x,y) .- (u,v) = (x-u,y-v)
(x,y) .+ (u,v) = (x+u,y+v)

(.*) :: Float -> PointInSpace -> PointInSpace
s .* (u,v) = (s*u,s*v)

infixl 6 .- , .+
infixl 7 .*

norm :: PointInSpace -> PointInSpace
norm (x,y) = let m = magV (x,y) in (x/m,y/m)

magV :: PointInSpace -> Float
magV (x,y) = sqrt (x**2 + y**2) 

limitMag :: Float -> PointInSpace -> PointInSpace
limitMag n pt = if (magV pt > n) 
                  then n .* (norm pt)
                  else pt

rotateV :: Float -> PointInSpace -> PointInSpace
rotateV r (x,y) = (x * cos r - y * sin r
                  ,x * sin r + y * cos r)
playGame =
 play
  (InWindow "Asteroids!" (550,550) (20,20))
  black
  24
  initialWorld
  drawWorld
  handleEvents
  simulateWorld

main = playGame

