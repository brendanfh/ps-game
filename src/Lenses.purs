module Lenses where

import Prelude
import Optic.Core (Lens', lens)


composeLenses :: forall a b. a -> (a -> b) -> b
composeLenses = flip ($)
infixl 1 composeLenses as &

status :: forall r a. Lens' { status :: a | r } a
status = lens (\r -> r.status) (\r val -> r { status = val })

num :: forall r a. Lens' { num :: a | r } a
num = lens (\r -> r.num) (\r val -> r { num = val })