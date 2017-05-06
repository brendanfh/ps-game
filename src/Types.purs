module Types where

import Control.Monad.Eff (kind Effect)
import Control.Monad.Eff.Ref (Ref)
import Data.Array
import Data.Eq

import GameMap (Map)
    
foreign import data GAME :: Effect

data GameStatus
    = Playing
    | MainMenu
    
derive instance gameStatusEq :: Eq GameStatus 


type GameState =
    { num :: Number
    , status :: GameStatus
    , keyboard :: Ref KeyboardState
    , grid :: Map
    }
    


type KeyboardState = Array Int