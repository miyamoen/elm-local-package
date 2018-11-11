module PackageSummary exposing (book, view)

import Bibliopola exposing (..)
import Bibliopola.Story as Story
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Elm.Version
import Fake
import SelectList
import Types exposing (Package)
import Url.Builder exposing (absolute)


view : Package -> Element msg
view package =
    let
        { authorName, packageName, summary, version } =
            SelectList.selected package
    in
    column
        [ paddingEach { top = 20, right = 0, bottom = 20 + 8, left = 0 }
        , spacing 8
        , width fill
        , Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
        , Border.color <| rgb255 238 238 238
        ]
        [ wrappedRow [ width fill, height <| px 30 ]
            [ link
                [ alignLeft
                , Font.size 24
                , Font.color <| rgb255 17 132 206
                , mouseOver
                    [ Font.color <| rgb255 234 21 122
                    , Border.shadow { size = 0, offset = ( 0, 2 ), blur = 0, color = rgb255 234 21 122 }
                    ]
                ]
                { url = absolute [ "packages", authorName, packageName, Elm.Version.toString version ] []
                , label = row [] [ text authorName, text "/", text packageName ]
                }
            , link
                [ alignRight
                , alignBottom
                , Font.size 16
                , Font.color <| rgb255 187 187 187
                , pointer
                , mouseOver
                    [ Border.shadow { size = 0, offset = ( 0, 1 ), blur = 0, color = rgb255 187 187 187 } ]
                ]
                { url = absolute [ "packages", authorName, packageName ] []
                , label =
                    text <|
                        String.join " "
                            [ if SelectList.afterLength package > 1 then
                                "..."

                              else
                                ""
                            , Elm.Version.toString version
                            , "-"
                            , "Overview"
                            ]
                }
            ]
        , paragraph [ Font.size 16, height <| px 24 ] [ text summary ]
        ]


book : Book
book =
    bookWithFrontCover "PackageSummary" (view Fake.package)


main : Bibliopola.Program
main =
    fromBook book
