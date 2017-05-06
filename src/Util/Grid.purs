module Util.Grid where

import Prelude
import Data.Array ((!!), (..))
import Data.Maybe (Maybe)
import Data.Tuple (Tuple(..))
import Optic.Core (Lens', lens)
import Util.Utils (Triple(..))

gridCells :: forall a. Lens' ( Grid a ) ( Array (Triple a Int Int) )
gridCells = lens (\(Grid r) -> r.cells) (\(Grid r) val -> Grid $ r { cells = val })

gridWidth :: forall a. Lens' ( Grid a ) Int
gridWidth = lens (\(Grid r) -> r.width) (\(Grid r) val -> Grid $ r { width = val })

gridHeight :: forall a. Lens' ( Grid a ) Int
gridHeight = lens (\(Grid r) -> r.height) (\(Grid r) val -> Grid $ r { height = val })

newtype Grid a =
    Grid { cells :: Array (Triple a Int Int)
         , width :: Int
         , height :: Int
         }

instance gridFunctor :: Functor Grid where
    map f (Grid grid) = Grid $ grid { cells = (\(Triple c x y) -> Triple (f c) x y) <$> grid.cells }

blankGrid :: forall a. Int -> Int -> a -> Grid a
blankGrid width height val =
    Grid { cells : initialCells
         , width : width
         , height : height
         }
    where
        w' = width - 1
        h' = height - 1
        initialCells =
            (Tuple <$> (0..w') <*> (0..h')) <#> \(Tuple x y) ->
                Triple val x y

getAt :: forall a. Int -> Int -> Grid a -> Maybe a
getAt x y (Grid grid) =
    let cells = grid.cells
        w = grid.width
        cell = cells !! (x + y * w)
    in cell <#> (\(Triple c _ _) -> c)
    
changeAt :: forall a. Int -> Int -> (a -> a) -> Grid a -> Grid a
changeAt x y f (Grid grid) =
    let cells' = grid.cells <#> (\(Triple cell cx cy) ->
            if cx == x && cy == y then
                Triple (f cell) cx cy
            else
                Triple cell cx cy
            )
    in Grid $ grid { cells = cells' } 

setAt :: forall a. Int -> Int -> a -> Grid a -> Grid a
setAt x y val grid = changeAt x y (\_ -> val) grid