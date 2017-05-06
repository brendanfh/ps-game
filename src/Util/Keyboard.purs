module Util.Keyboard where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Ref
import Data.Array
import Types (GAME, KeyboardState)

foreign import onKeyDown :: forall e. (Int -> Eff ( game :: GAME | e ) Unit) -> Eff ( game :: GAME | e ) Unit

foreign import onKeyUp :: forall e. (Int -> Eff ( game :: GAME | e ) Unit) -> Eff ( game :: GAME | e ) Unit

initialState :: KeyboardState
initialState = []

initialize :: forall e. Eff ( ref :: REF, game :: GAME | e ) ( Ref KeyboardState )
initialize = do
    keyRef <- newRef initialState
    onKeyDown (\key ->
        modifyRef keyRef ((<>) [ key ])
    )
    onKeyUp (\key ->
        modifyRef keyRef (filter ((/=) key))
    )
    pure keyRef

isDown :: forall e. Ref KeyboardState -> Int -> Eff ( ref :: REF | e ) Boolean
isDown keyRef key = do
    state <- readRef keyRef
    pure (isDown' state key)

isDown' :: KeyboardState -> Int -> Boolean
isDown' keys key = foldl (\acc val -> acc || (val == key)) false keys