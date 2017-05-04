module Types where

import Control.Monad.Eff (kind Effect)
import Control.Monad.Eff.Ref (Ref)
import Data.Array
import Data.Eq
    
foreign import data GAME :: Effect

data GameStatus
    = Playing
    | MainMenu
    
derive instance gameStatusEq :: Eq GameStatus 


type GameState =
    { num :: Number
    , status :: GameStatus
    , keyboard :: Ref KeyboardState
    }
    


type KeyboardState = Array Int