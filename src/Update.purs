module Update
    ( update )
    where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Ref
import Optic.Core

import GameMap (BubbleColor(..))
import Lenses
import Types
import Util.Grid as G
import Util.Keyboard as K


updateGame :: forall e. Number -> Ref GameState -> Eff ( ref :: REF | e ) Unit
updateGame time stateRef = do
    state <- readRef stateRef
    ifM (K.isDown state.keyboard 32)
        (modifyRef stateRef (grid %~ G.setAt 1 0 { color : White }))
        (pure unit)
    modifyRef stateRef ( num +~ time )


update' :: Number -> GameStatus -> Ref GameState -> Eff _ Unit
update' time Playing stateRef = do
    foreachE [ updateGame time ]
        (\f -> do
            f stateRef
            pure unit)

update' _ _ _ = pure unit
    
        
update :: forall e. Number -> Ref GameState -> Eff ( ref :: REF | e ) Unit
update time stateRef = do
    state <- readRef stateRef
    let gameStatus = state ^. status
    update' time gameStatus stateRef
