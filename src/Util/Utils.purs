module Util.Utils where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Random (RANDOM, randomInt)
import Data.Array (length, (!!))
import Data.Maybe (fromJust)
import Partial.Unsafe (unsafePartial)

data Triple a b c = Triple a b c

choose :: forall e. Array ~> Eff (random :: RANDOM | e)
choose [x] = pure x
choose xs = unsafePartial $ do
    idx <- randomInt 0 (length xs - 1)
    pure $ fromJust $ xs !! idx