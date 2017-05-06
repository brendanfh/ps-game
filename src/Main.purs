module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Ref (REF, newRef)
import Control.Monad.Eff.Random (RANDOM)
import Data.Maybe (Maybe(..))
import GameMap
import Graphics.Canvas as C
import Partial.Unsafe (unsafePartial)
import Types (GAME, GameState, GameStatus(..))
import Update (update)
import Util.Keyboard as K
import Util.RequestAnimationFrame (requestAnimationFrame)
import View (view)

initial :: forall e. Eff ( ref :: REF, random :: RANDOM | e ) GameState
initial = do
    keyRef <- newRef K.initialState
    grid <- generateMap 10 10
    pure { num : 0.0, status : Playing, keyboard : keyRef, grid : grid }

main :: Eff ( game :: GAME, ref :: REF, canvas :: C.CANVAS, random :: RANDOM ) Unit
main = unsafePartial $ do
    Just canvas <- C.getCanvasElementById "maincanvas"
    
    _ <- C.setCanvasWidth 338.0 canvas
    _ <- C.setCanvasHeight 600.0 canvas
    ctx <- C.getContext2D canvas
    
    initialGameState <- initial
    K.initialize initialGameState.keyboard
    gameRef <- newRef initialGameState
    
    let loop time = do
            update time gameRef
            view ctx gameRef
            requestAnimationFrame loop
    
    requestAnimationFrame loop
    
    pure unit
