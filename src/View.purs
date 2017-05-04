module View
    ( view )
    where
    
import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Ref
import Graphics.Canvas as C
import Optic.Core

import Lenses
import Types
import Util.Math (sin)
    
view' :: forall e. C.Context2D -> GameStatus -> Ref GameState -> Eff ( canvas :: C.CANVAS, ref :: REF | e ) Unit
view' ctx Playing stateRef = do
    state <- readRef stateRef
    _ <- C.setFillStyle "white" ctx
    _ <- C.fillRect ctx { x : 0.0, y : 0.0, w : 800.0, h : 600.0 }
    _ <- C.setFillStyle "black" ctx
    _ <- C.fillRect ctx { x : (sin state.num) * 100.0 + 100.0, y : 0.0, w : 100.0, h : 100.0 }
    pure unit

view' _ _ _ = pure unit

view :: forall e. C.Context2D -> Ref GameState -> Eff ( canvas :: C.CANVAS, ref :: REF | e ) Unit
view ctx stateRef = do
    state <- readRef stateRef
    let gameStatus = state ^. status
    view' ctx gameStatus stateRef