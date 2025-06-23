module Elm.Declare.Extra exposing (withDocumentation)

import Elm


withDocumentation :
    String
    -> { a | declaration : Elm.Declaration }
    -> { a | declaration : Elm.Declaration }
withDocumentation doc function =
    { function | declaration = Elm.withDocumentation doc function.declaration }
