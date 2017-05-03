module Main where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Random (random)
import Data.Maybe (Maybe(..))
import Graphics.Canvas as C
import Partial.Unsafe (unsafePartial)
import Util.Focus as F
import Util.Math

foreign import data GAME :: Effect

foreign import requestAnimationFrame :: forall e. (Number -> Eff ( game :: GAME | e ) Unit) -> Eff ( game :: GAME | e) Unit

num :: forall r a. F.Focus { num :: a | r } a
num = F.create (\r -> r.num) (\f r -> r { num = f r.num })

type GameState =
    { num :: Number
    }

initial :: Eff _ GameState
initial = do
    pure { num : 0.0 }

update :: Number -> GameState -> Eff _ GameState
update time gs = do
    let ngs = F.update num (\n -> n + time) gs
    pure ngs

view :: forall e. GameState -> C.Context2D -> Eff ( game :: GAME, canvas :: C.CANVAS | e ) Unit
view gs ctx = do
    _ <- C.setFillStyle "white" ctx
    _ <- C.fillRect ctx { x : 0.0, y : 0.0, w : 800.0, h : 600.0 }
    _ <- C.setFillStyle "black" ctx
    _ <- C.fillRect ctx { x : (sin gs.num) * 100.0 + 100.0, y : 0.0, w : 100.0, h : 100.0 }
    pure unit

main :: Eff _ Unit
main = unsafePartial $ do
    Just canvas <- C.getCanvasElementById "maincanvas"
    ctx <- C.getContext2D canvas
    
    initialGameState <- initial
    
    let loop gameState time = do
            nState <- update time gameState
            view nState ctx
            
            requestAnimationFrame (loop nState)
    
    requestAnimationFrame (loop initialGameState)
    
    pure unit
