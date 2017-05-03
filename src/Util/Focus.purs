module Util.Focus where

type Focus b s = { get :: b -> s
                 , update :: (s -> s) -> b -> b }
                 
create :: forall b s. (b -> s) -> ((s -> s) -> b -> b) -> Focus b s
create get update =
    { get : get, update : update }

get :: forall b s. Focus b s -> b -> s
get { get } b = get b

update :: forall b s. Focus b s -> (s -> s) -> b -> b
update { update } f b = update f b

set :: forall b s. Focus b s -> s -> b -> b
set { update } s b = update (\_ -> s) b

compose :: forall b m s. Focus b m -> Focus m s -> Focus b s
compose bFocus sFocus =
    { get : nGet, update : nUpdate }
    where
        nGet b = sFocus.get (bFocus.get b)
        
        nUpdate f b = bFocus.update (sFocus.update f) b

infixr 4 compose as .>