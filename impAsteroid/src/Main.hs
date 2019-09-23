module Main where
import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Graphics.Gloss.Interface.Pure.Simulate
import Graphics.Gloss.Interface.Pure.Display

data AsteroidWorld = Play [Rock] Ship [Bullet]
                   | GameOver 
                   deriving (Eq,Show)

type Velocity     = (Float,Float)
type Size         = Float
type Age          = Float
type PointInSpace = (Float,Float)


data Ship    = Ship PointInSpace Velocity
    deriving (Eq,Show)
data Bullet  = Bullet PointInSpace Velocity Age
    deriving (Eq,Show)
data Rock    = Rock PointInSpace Size Velocity
    deriving (Eq,Show)

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

drawWorld :: AsteroidWorld -> Picture
drawWorld GameOver
  = scale 0.3 0.3
    . translate (-400) 0
    . color green
    . text
    $ "You suck!"

drawWorld (Play rocks (Ship (x,y) (vx,vy)) bullets)
  = pictures [ship, asteroids, shots]
   where
    ship      = color green (pictures [translate x y (ThickCircle 10 2)])
    asteroids = pictures [translate x y (color red (circle s))
                         | Rock   (x,y) s _ <- rocks]
    shots     = pictures [translate x y (color red (circle 2))
                         | Bullet (x,y) _ _ <- bullets]

main = display
        (InWindow "Drawing our initial world"
                   (550,550)
                   (20,20))
       black
       (drawWorld initialWorld)


