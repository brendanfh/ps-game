module Main where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Random (random)
import Control.Monad.Eff.Ref
import Data.Maybe (Maybe(..))
import Graphics.Canvas as C
import Lenses
import Optic.Core
import Partial.Unsafe (unsafePartial)
import Types
import Util.Keyboard as K
import Util.Math
import Util.RequestAnimationFrame

initial :: Eff _ GameState
initial = do
    keyRef <- newRef K.initialState
    pure { num : 0.0, status : Playing, keyboard : keyRef }

update :: Number -> GameState -> Eff _ GameState
update time state
    | state.status == Playing = do
        state0 <-
            ifM (K.isDown state.keyboard 32)
                (pure (state # num .~ 0.0))
                (pure state)
        pure (state0 # num +~ time)
        
    | otherwise = do
        pure state

view :: forall e. GameState -> C.Context2D -> Eff ( game :: GAME, canvas :: C.CANVAS | e ) Unit
view state ctx
    | state.status == Playing = do
        _ <- C.setFillStyle "white" ctx
        _ <- C.fillRect ctx { x : 0.0, y : 0.0, w : 800.0, h : 600.0 }
        _ <- C.setFillStyle "black" ctx
        _ <- C.fillRect ctx { x : (sin state.num) * 100.0 + 100.0, y : 0.0, w : 100.0, h : 100.0 }
        pure unit
        
    | otherwise = do
        pure unit

main :: Eff _ Unit
main = unsafePartial $ do
    Just canvas <- C.getCanvasElementById "maincanvas"
    ctx <- C.getContext2D canvas
    
    initialGameState <- initial
    K.initialize initialGameState.keyboard
    gameRef <- newRef initialGameState
    
    let loop time = do
            gameState <- readRef gameRef
            nState <- update time gameState
            view nState ctx
            
            writeRef gameRef nState
            requestAnimationFrame loop
    
    requestAnimationFrame loop
    
    pure unit
