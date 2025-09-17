module Gen.Url.Builder exposing (call_)

{-|


# Generated bindings for Url.Builder

@docs call_

-}

import Elm
import Elm.Annotation as Type


call_ :
    { absolute : Elm.Expression -> Elm.Expression -> Elm.Expression
    , relative : Elm.Expression -> Elm.Expression -> Elm.Expression
    , crossOrigin :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , custom :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , string : Elm.Expression -> Elm.Expression -> Elm.Expression
    , int : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toQuery : Elm.Expression -> Elm.Expression
    }
call_ =
    { absolute =
        \absoluteArg_ absoluteArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Url", "Builder" ]
                    , name = "absolute"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list Type.string
                                , Type.list
                                    (Type.namedWith
                                        [ "Url", "Builder" ]
                                        "QueryParameter"
                                        []
                                    )
                                ]
                                Type.string
                            )
                    }
                )
                [ absoluteArg_, absoluteArg_0 ]
    , relative =
        \relativeArg_ relativeArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Url", "Builder" ]
                    , name = "relative"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list Type.string
                                , Type.list
                                    (Type.namedWith
                                        [ "Url", "Builder" ]
                                        "QueryParameter"
                                        []
                                    )
                                ]
                                Type.string
                            )
                    }
                )
                [ relativeArg_, relativeArg_0 ]
    , crossOrigin =
        \crossOriginArg_ crossOriginArg_0 crossOriginArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Url", "Builder" ]
                    , name = "crossOrigin"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.list Type.string
                                , Type.list
                                    (Type.namedWith
                                        [ "Url", "Builder" ]
                                        "QueryParameter"
                                        []
                                    )
                                ]
                                Type.string
                            )
                    }
                )
                [ crossOriginArg_, crossOriginArg_0, crossOriginArg_1 ]
    , custom =
        \customArg_ customArg_0 customArg_1 customArg_2 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Url", "Builder" ]
                    , name = "custom"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Url", "Builder" ]
                                    "Root"
                                    []
                                , Type.list Type.string
                                , Type.list
                                    (Type.namedWith
                                        [ "Url", "Builder" ]
                                        "QueryParameter"
                                        []
                                    )
                                , Type.maybe Type.string
                                ]
                                Type.string
                            )
                    }
                )
                [ customArg_, customArg_0, customArg_1, customArg_2 ]
    , string =
        \stringArg_ stringArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Url", "Builder" ]
                    , name = "string"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                (Type.namedWith
                                    [ "Url", "Builder" ]
                                    "QueryParameter"
                                    []
                                )
                            )
                    }
                )
                [ stringArg_, stringArg_0 ]
    , int =
        \intArg_ intArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Url", "Builder" ]
                    , name = "int"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.int ]
                                (Type.namedWith
                                    [ "Url", "Builder" ]
                                    "QueryParameter"
                                    []
                                )
                            )
                    }
                )
                [ intArg_, intArg_0 ]
    , toQuery =
        \toQueryArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Url", "Builder" ]
                    , name = "toQuery"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list
                                    (Type.namedWith
                                        [ "Url", "Builder" ]
                                        "QueryParameter"
                                        []
                                    )
                                ]
                                Type.string
                            )
                    }
                )
                [ toQueryArg_ ]
    }
