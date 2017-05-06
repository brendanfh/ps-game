module GameMap where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Random
import Data.Int (toNumber)
import Data.Traversable (for, for_)
import Graphics.Canvas as C
import Math as Math
import Optic.Core
import Util.Grid
import Util.Utils

data BubbleColor = Red | Purple | Blue | Green | White

defaultColors :: Array BubbleColor
defaultColors = [ Red, Blue, White ]

colorblindColors :: Array BubbleColor
colorblindColors = [ Purple, Green, White ]

instance showBubbleColor :: Show BubbleColor where
    show Red = "red"
    show Purple = "#ac119d"
    show Blue = "blue"
    show Green = "green"
    show White = "White"
    show _ = "black"

type Bubble =
    { color :: BubbleColor
    }
defaultBubble :: Bubble
defaultBubble = { color : White }
   
type Map = Grid Bubble

generateMap :: forall e. Int -> Int -> Eff ( random :: RANDOM | e ) Map
generateMap width height = do
    let blankMap = blankGrid width height defaultBubble
        cells = blankMap ^. gridCells
    newCells <-
        for cells $ \(Triple cell x y) -> do
            color <- choose colorblindColors
            pure $ (Triple (cell { color = color }) x y)
    pure $ blankMap # gridCells .~ newCells
    
view :: forall e. C.Context2D -> Map -> Eff ( canvas :: C.CANVAS | e ) Unit
view ctx gameMap = do
    let cells = gameMap ^. gridCells
    for_ cells $ \(Triple cell x y) -> do
        _ <- C.setFillStyle (show cell.color) ctx
        _ <- C.beginPath ctx
        _ <- C.arc ctx { x : (toNumber x) * 32.0 + 16.0
                       , y : (toNumber y) * 32.0 + 16.0
                       , r : 12.0
                       , start : 0.0
                       , end : Math.pi * 2.0
                       }
        _ <- C.closePath ctx
        _ <- C.fill ctx
        pure unit
    pure unit