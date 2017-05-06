module View
    ( view )
    where
    
import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Ref
import GameMap as GM
import Graphics.Canvas as C

import Types

view' :: forall e. C.Context2D -> GameStatus -> Ref GameState -> Eff ( canvas :: C.CANVAS, ref :: REF | e ) Unit
view' ctx Playing stateRef = do
    state <- readRef stateRef
    _ <- C.setFillStyle "black" ctx
    _ <- C.fillRect ctx { x : 0.0, y : 0.0, w : 338.0, h : 600.0 }
    GM.view ctx state.grid
    pure unit

view' _ _ _ = pure unit

view :: forall e. C.Context2D -> Ref GameState -> Eff ( canvas :: C.CANVAS, ref :: REF | e ) Unit
view ctx stateRef = do
    state <- readRef stateRef
    let gameStatus = state.status
    view' ctx gameStatus stateRef