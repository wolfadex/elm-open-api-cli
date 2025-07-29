module Gen.String exposing (annotation_, call_, values_)

{-|


# Generated bindings for String

@docs annotation_, call_, values_

-}

import Elm
import Elm.Annotation as Type


annotation_ : { string : Type.Annotation }
annotation_ =
    { string = Type.namedWith [] "String" [] }


call_ :
    { isEmpty : Elm.Expression -> Elm.Expression
    , length : Elm.Expression -> Elm.Expression
    , reverse : Elm.Expression -> Elm.Expression
    , repeat : Elm.Expression -> Elm.Expression -> Elm.Expression
    , replace :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , append : Elm.Expression -> Elm.Expression -> Elm.Expression
    , concat : Elm.Expression -> Elm.Expression
    , split : Elm.Expression -> Elm.Expression -> Elm.Expression
    , join : Elm.Expression -> Elm.Expression -> Elm.Expression
    , words : Elm.Expression -> Elm.Expression
    , lines : Elm.Expression -> Elm.Expression
    , slice :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , left : Elm.Expression -> Elm.Expression -> Elm.Expression
    , right : Elm.Expression -> Elm.Expression -> Elm.Expression
    , dropLeft : Elm.Expression -> Elm.Expression -> Elm.Expression
    , dropRight : Elm.Expression -> Elm.Expression -> Elm.Expression
    , contains : Elm.Expression -> Elm.Expression -> Elm.Expression
    , startsWith : Elm.Expression -> Elm.Expression -> Elm.Expression
    , endsWith : Elm.Expression -> Elm.Expression -> Elm.Expression
    , indexes : Elm.Expression -> Elm.Expression -> Elm.Expression
    , indices : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toInt : Elm.Expression -> Elm.Expression
    , fromInt : Elm.Expression -> Elm.Expression
    , toFloat : Elm.Expression -> Elm.Expression
    , fromFloat : Elm.Expression -> Elm.Expression
    , fromChar : Elm.Expression -> Elm.Expression
    , cons : Elm.Expression -> Elm.Expression -> Elm.Expression
    , uncons : Elm.Expression -> Elm.Expression
    , toList : Elm.Expression -> Elm.Expression
    , fromList : Elm.Expression -> Elm.Expression
    , toUpper : Elm.Expression -> Elm.Expression
    , toLower : Elm.Expression -> Elm.Expression
    , pad : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , padLeft :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , padRight :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , trim : Elm.Expression -> Elm.Expression
    , trimLeft : Elm.Expression -> Elm.Expression
    , trimRight : Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    , filter : Elm.Expression -> Elm.Expression -> Elm.Expression
    , foldl :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , foldr :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , any : Elm.Expression -> Elm.Expression -> Elm.Expression
    , all : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { isEmpty =
        \isEmptyArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "isEmpty"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.bool)
                    }
                )
                [ isEmptyArg_ ]
    , length =
        \lengthArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "length"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.int)
                    }
                )
                [ lengthArg_ ]
    , reverse =
        \reverseArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "reverse"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.string)
                    }
                )
                [ reverseArg_ ]
    , repeat =
        \repeatArg_ repeatArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "repeat"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.string ]
                                Type.string
                            )
                    }
                )
                [ repeatArg_, repeatArg_0 ]
    , replace =
        \replaceArg_ replaceArg_0 replaceArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "replace"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string, Type.string ]
                                Type.string
                            )
                    }
                )
                [ replaceArg_, replaceArg_0, replaceArg_1 ]
    , append =
        \appendArg_ appendArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "append"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                Type.string
                            )
                    }
                )
                [ appendArg_, appendArg_0 ]
    , concat =
        \concatArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "concat"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list Type.string ]
                                Type.string
                            )
                    }
                )
                [ concatArg_ ]
    , split =
        \splitArg_ splitArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "split"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                (Type.list Type.string)
                            )
                    }
                )
                [ splitArg_, splitArg_0 ]
    , join =
        \joinArg_ joinArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "join"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.list Type.string ]
                                Type.string
                            )
                    }
                )
                [ joinArg_, joinArg_0 ]
    , words =
        \wordsArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "words"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.list Type.string)
                            )
                    }
                )
                [ wordsArg_ ]
    , lines =
        \linesArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "lines"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.list Type.string)
                            )
                    }
                )
                [ linesArg_ ]
    , slice =
        \sliceArg_ sliceArg_0 sliceArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "slice"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.int, Type.string ]
                                Type.string
                            )
                    }
                )
                [ sliceArg_, sliceArg_0, sliceArg_1 ]
    , left =
        \leftArg_ leftArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "left"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.string ]
                                Type.string
                            )
                    }
                )
                [ leftArg_, leftArg_0 ]
    , right =
        \rightArg_ rightArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "right"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.string ]
                                Type.string
                            )
                    }
                )
                [ rightArg_, rightArg_0 ]
    , dropLeft =
        \dropLeftArg_ dropLeftArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "dropLeft"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.string ]
                                Type.string
                            )
                    }
                )
                [ dropLeftArg_, dropLeftArg_0 ]
    , dropRight =
        \dropRightArg_ dropRightArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "dropRight"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.string ]
                                Type.string
                            )
                    }
                )
                [ dropRightArg_, dropRightArg_0 ]
    , contains =
        \containsArg_ containsArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "contains"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                Type.bool
                            )
                    }
                )
                [ containsArg_, containsArg_0 ]
    , startsWith =
        \startsWithArg_ startsWithArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "startsWith"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                Type.bool
                            )
                    }
                )
                [ startsWithArg_, startsWithArg_0 ]
    , endsWith =
        \endsWithArg_ endsWithArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "endsWith"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                Type.bool
                            )
                    }
                )
                [ endsWithArg_, endsWithArg_0 ]
    , indexes =
        \indexesArg_ indexesArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "indexes"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                (Type.list Type.int)
                            )
                    }
                )
                [ indexesArg_, indexesArg_0 ]
    , indices =
        \indicesArg_ indicesArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "indices"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                (Type.list Type.int)
                            )
                    }
                )
                [ indicesArg_, indicesArg_0 ]
    , toInt =
        \toIntArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "toInt"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.maybe Type.int)
                            )
                    }
                )
                [ toIntArg_ ]
    , fromInt =
        \fromIntArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "fromInt"
                    , annotation =
                        Just (Type.function [ Type.int ] Type.string)
                    }
                )
                [ fromIntArg_ ]
    , toFloat =
        \toFloatArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "toFloat"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.maybe Type.float)
                            )
                    }
                )
                [ toFloatArg_ ]
    , fromFloat =
        \fromFloatArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "fromFloat"
                    , annotation =
                        Just (Type.function [ Type.float ] Type.string)
                    }
                )
                [ fromFloatArg_ ]
    , fromChar =
        \fromCharArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "fromChar"
                    , annotation =
                        Just (Type.function [ Type.char ] Type.string)
                    }
                )
                [ fromCharArg_ ]
    , cons =
        \consArg_ consArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "cons"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.char, Type.string ]
                                Type.string
                            )
                    }
                )
                [ consArg_, consArg_0 ]
    , uncons =
        \unconsArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "uncons"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.maybe (Type.tuple Type.char Type.string))
                            )
                    }
                )
                [ unconsArg_ ]
    , toList =
        \toListArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "toList"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.list Type.char)
                            )
                    }
                )
                [ toListArg_ ]
    , fromList =
        \fromListArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "fromList"
                    , annotation =
                        Just
                            (Type.function [ Type.list Type.char ] Type.string)
                    }
                )
                [ fromListArg_ ]
    , toUpper =
        \toUpperArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "toUpper"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.string)
                    }
                )
                [ toUpperArg_ ]
    , toLower =
        \toLowerArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "toLower"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.string)
                    }
                )
                [ toLowerArg_ ]
    , pad =
        \padArg_ padArg_0 padArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "pad"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.char, Type.string ]
                                Type.string
                            )
                    }
                )
                [ padArg_, padArg_0, padArg_1 ]
    , padLeft =
        \padLeftArg_ padLeftArg_0 padLeftArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "padLeft"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.char, Type.string ]
                                Type.string
                            )
                    }
                )
                [ padLeftArg_, padLeftArg_0, padLeftArg_1 ]
    , padRight =
        \padRightArg_ padRightArg_0 padRightArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "padRight"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.char, Type.string ]
                                Type.string
                            )
                    }
                )
                [ padRightArg_, padRightArg_0, padRightArg_1 ]
    , trim =
        \trimArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "trim"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.string)
                    }
                )
                [ trimArg_ ]
    , trimLeft =
        \trimLeftArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "trimLeft"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.string)
                    }
                )
                [ trimLeftArg_ ]
    , trimRight =
        \trimRightArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "trimRight"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.string)
                    }
                )
                [ trimRightArg_ ]
    , map =
        \mapArg_ mapArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "map"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.char ] Type.char
                                , Type.string
                                ]
                                Type.string
                            )
                    }
                )
                [ mapArg_, mapArg_0 ]
    , filter =
        \filterArg_ filterArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "filter"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.char ] Type.bool
                                , Type.string
                                ]
                                Type.string
                            )
                    }
                )
                [ filterArg_, filterArg_0 ]
    , foldl =
        \foldlArg_ foldlArg_0 foldlArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "foldl"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.char, Type.var "b" ]
                                    (Type.var "b")
                                , Type.var "b"
                                , Type.string
                                ]
                                (Type.var "b")
                            )
                    }
                )
                [ foldlArg_, foldlArg_0, foldlArg_1 ]
    , foldr =
        \foldrArg_ foldrArg_0 foldrArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "foldr"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.char, Type.var "b" ]
                                    (Type.var "b")
                                , Type.var "b"
                                , Type.string
                                ]
                                (Type.var "b")
                            )
                    }
                )
                [ foldrArg_, foldrArg_0, foldrArg_1 ]
    , any =
        \anyArg_ anyArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "any"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.char ] Type.bool
                                , Type.string
                                ]
                                Type.bool
                            )
                    }
                )
                [ anyArg_, anyArg_0 ]
    , all =
        \allArg_ allArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "all"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.char ] Type.bool
                                , Type.string
                                ]
                                Type.bool
                            )
                    }
                )
                [ allArg_, allArg_0 ]
    }


values_ :
    { isEmpty : Elm.Expression
    , length : Elm.Expression
    , reverse : Elm.Expression
    , repeat : Elm.Expression
    , replace : Elm.Expression
    , append : Elm.Expression
    , concat : Elm.Expression
    , split : Elm.Expression
    , join : Elm.Expression
    , words : Elm.Expression
    , lines : Elm.Expression
    , slice : Elm.Expression
    , left : Elm.Expression
    , right : Elm.Expression
    , dropLeft : Elm.Expression
    , dropRight : Elm.Expression
    , contains : Elm.Expression
    , startsWith : Elm.Expression
    , endsWith : Elm.Expression
    , indexes : Elm.Expression
    , indices : Elm.Expression
    , toInt : Elm.Expression
    , fromInt : Elm.Expression
    , toFloat : Elm.Expression
    , fromFloat : Elm.Expression
    , fromChar : Elm.Expression
    , cons : Elm.Expression
    , uncons : Elm.Expression
    , toList : Elm.Expression
    , fromList : Elm.Expression
    , toUpper : Elm.Expression
    , toLower : Elm.Expression
    , pad : Elm.Expression
    , padLeft : Elm.Expression
    , padRight : Elm.Expression
    , trim : Elm.Expression
    , trimLeft : Elm.Expression
    , trimRight : Elm.Expression
    , map : Elm.Expression
    , filter : Elm.Expression
    , foldl : Elm.Expression
    , foldr : Elm.Expression
    , any : Elm.Expression
    , all : Elm.Expression
    }
values_ =
    { isEmpty =
        Elm.value
            { importFrom = [ "String" ]
            , name = "isEmpty"
            , annotation = Just (Type.function [ Type.string ] Type.bool)
            }
    , length =
        Elm.value
            { importFrom = [ "String" ]
            , name = "length"
            , annotation = Just (Type.function [ Type.string ] Type.int)
            }
    , reverse =
        Elm.value
            { importFrom = [ "String" ]
            , name = "reverse"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , repeat =
        Elm.value
            { importFrom = [ "String" ]
            , name = "repeat"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
    , replace =
        Elm.value
            { importFrom = [ "String" ]
            , name = "replace"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.string, Type.string ]
                        Type.string
                    )
            }
    , append =
        Elm.value
            { importFrom = [ "String" ]
            , name = "append"
            , annotation =
                Just (Type.function [ Type.string, Type.string ] Type.string)
            }
    , concat =
        Elm.value
            { importFrom = [ "String" ]
            , name = "concat"
            , annotation =
                Just (Type.function [ Type.list Type.string ] Type.string)
            }
    , split =
        Elm.value
            { importFrom = [ "String" ]
            , name = "split"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.string ]
                        (Type.list Type.string)
                    )
            }
    , join =
        Elm.value
            { importFrom = [ "String" ]
            , name = "join"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.list Type.string ]
                        Type.string
                    )
            }
    , words =
        Elm.value
            { importFrom = [ "String" ]
            , name = "words"
            , annotation =
                Just (Type.function [ Type.string ] (Type.list Type.string))
            }
    , lines =
        Elm.value
            { importFrom = [ "String" ]
            , name = "lines"
            , annotation =
                Just (Type.function [ Type.string ] (Type.list Type.string))
            }
    , slice =
        Elm.value
            { importFrom = [ "String" ]
            , name = "slice"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.int, Type.string ]
                        Type.string
                    )
            }
    , left =
        Elm.value
            { importFrom = [ "String" ]
            , name = "left"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
    , right =
        Elm.value
            { importFrom = [ "String" ]
            , name = "right"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
    , dropLeft =
        Elm.value
            { importFrom = [ "String" ]
            , name = "dropLeft"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
    , dropRight =
        Elm.value
            { importFrom = [ "String" ]
            , name = "dropRight"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
    , contains =
        Elm.value
            { importFrom = [ "String" ]
            , name = "contains"
            , annotation =
                Just (Type.function [ Type.string, Type.string ] Type.bool)
            }
    , startsWith =
        Elm.value
            { importFrom = [ "String" ]
            , name = "startsWith"
            , annotation =
                Just (Type.function [ Type.string, Type.string ] Type.bool)
            }
    , endsWith =
        Elm.value
            { importFrom = [ "String" ]
            , name = "endsWith"
            , annotation =
                Just (Type.function [ Type.string, Type.string ] Type.bool)
            }
    , indexes =
        Elm.value
            { importFrom = [ "String" ]
            , name = "indexes"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.string ]
                        (Type.list Type.int)
                    )
            }
    , indices =
        Elm.value
            { importFrom = [ "String" ]
            , name = "indices"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.string ]
                        (Type.list Type.int)
                    )
            }
    , toInt =
        Elm.value
            { importFrom = [ "String" ]
            , name = "toInt"
            , annotation =
                Just (Type.function [ Type.string ] (Type.maybe Type.int))
            }
    , fromInt =
        Elm.value
            { importFrom = [ "String" ]
            , name = "fromInt"
            , annotation = Just (Type.function [ Type.int ] Type.string)
            }
    , toFloat =
        Elm.value
            { importFrom = [ "String" ]
            , name = "toFloat"
            , annotation =
                Just (Type.function [ Type.string ] (Type.maybe Type.float))
            }
    , fromFloat =
        Elm.value
            { importFrom = [ "String" ]
            , name = "fromFloat"
            , annotation = Just (Type.function [ Type.float ] Type.string)
            }
    , fromChar =
        Elm.value
            { importFrom = [ "String" ]
            , name = "fromChar"
            , annotation = Just (Type.function [ Type.char ] Type.string)
            }
    , cons =
        Elm.value
            { importFrom = [ "String" ]
            , name = "cons"
            , annotation =
                Just (Type.function [ Type.char, Type.string ] Type.string)
            }
    , uncons =
        Elm.value
            { importFrom = [ "String" ]
            , name = "uncons"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.maybe (Type.tuple Type.char Type.string))
                    )
            }
    , toList =
        Elm.value
            { importFrom = [ "String" ]
            , name = "toList"
            , annotation =
                Just (Type.function [ Type.string ] (Type.list Type.char))
            }
    , fromList =
        Elm.value
            { importFrom = [ "String" ]
            , name = "fromList"
            , annotation =
                Just (Type.function [ Type.list Type.char ] Type.string)
            }
    , toUpper =
        Elm.value
            { importFrom = [ "String" ]
            , name = "toUpper"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , toLower =
        Elm.value
            { importFrom = [ "String" ]
            , name = "toLower"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , pad =
        Elm.value
            { importFrom = [ "String" ]
            , name = "pad"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.char, Type.string ]
                        Type.string
                    )
            }
    , padLeft =
        Elm.value
            { importFrom = [ "String" ]
            , name = "padLeft"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.char, Type.string ]
                        Type.string
                    )
            }
    , padRight =
        Elm.value
            { importFrom = [ "String" ]
            , name = "padRight"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.char, Type.string ]
                        Type.string
                    )
            }
    , trim =
        Elm.value
            { importFrom = [ "String" ]
            , name = "trim"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , trimLeft =
        Elm.value
            { importFrom = [ "String" ]
            , name = "trimLeft"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , trimRight =
        Elm.value
            { importFrom = [ "String" ]
            , name = "trimRight"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , map =
        Elm.value
            { importFrom = [ "String" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.char ] Type.char, Type.string ]
                        Type.string
                    )
            }
    , filter =
        Elm.value
            { importFrom = [ "String" ]
            , name = "filter"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.char ] Type.bool, Type.string ]
                        Type.string
                    )
            }
    , foldl =
        Elm.value
            { importFrom = [ "String" ]
            , name = "foldl"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.char, Type.var "b" ]
                            (Type.var "b")
                        , Type.var "b"
                        , Type.string
                        ]
                        (Type.var "b")
                    )
            }
    , foldr =
        Elm.value
            { importFrom = [ "String" ]
            , name = "foldr"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.char, Type.var "b" ]
                            (Type.var "b")
                        , Type.var "b"
                        , Type.string
                        ]
                        (Type.var "b")
                    )
            }
    , any =
        Elm.value
            { importFrom = [ "String" ]
            , name = "any"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.char ] Type.bool, Type.string ]
                        Type.bool
                    )
            }
    , all =
        Elm.value
            { importFrom = [ "String" ]
            , name = "all"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.char ] Type.bool, Type.string ]
                        Type.bool
                    )
            }
    }
