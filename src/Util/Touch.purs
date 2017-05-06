module Util.Touch where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Ref

foreign import setupTouch :: forall e. Ref TouchSystem -> Eff ( ref :: REF | e ) Unit

type Touch = { x :: Number, y :: Number, identifier :: Int }

type TouchSystem = { touches :: Array Touch }

initialTouchSystem :: TouchSystem
initialTouchSystem = { touches : [] }

initialize :: forall e. Eff ( ref :: REF | e ) ( Ref TouchSystem )
initialize = do
    touchRef <- newRef initialTouchSystem
    setupTouch touchRef
    pure touchRef
    