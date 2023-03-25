module Main exposing (main)

import Array exposing (Array)
import Browser
import Debug
import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events
import Maybe
import Random


type Color
    = Red
    | Blue


type alias Cell =
    Maybe Color


type alias Grid =
    Array Cell


type Model
    = GameInProgress Grid
    | Fail
    | Win


type GameMsg
    = NewGrid Grid
    | SelectCell Int


init : flags -> ( Model, Cmd GameMsg )
init _ =
    ( GameInProgress Array.empty, Random.generate NewGrid gridGenerator )


view : Model -> Html GameMsg
view model =
    case model of
        GameInProgress grid ->
            renderGrid grid

        Fail ->
            Html.text "Failed!"

        Win ->
            Html.text "Win, congratulations!"


update : GameMsg -> Model -> ( Model, Cmd GameMsg )
update msg model =
    case msg of
        NewGrid grid ->
            ( GameInProgress grid, Cmd.none )

        SelectCell position ->
            case model of
                GameInProgress grid ->
                    ( GameInProgress <| clearArea position grid, Cmd.none )

                _ ->
                    ( model, Cmd.none )


main : Program () Model GameMsg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


gridSize : Int
gridSize =
    5


gridGenerator : Random.Generator Grid
gridGenerator =
    Random.map Just (Random.uniform Red [ Blue ])
        |> Random.list (gridSize ^ 2)
        |> Random.map Array.fromList


renderCell : Int -> Cell -> Html GameMsg
renderCell index =
    let
        cellTemplate color =
            Html.div
                [ Attr.style "border-radius" "0.3em"
                , Attr.style "background-color" color
                , Html.Events.onClick <| SelectCell index
                ]
                [ Html.text (String.fromInt index) ]
    in
    Maybe.map
        (\color ->
            case color of
                Blue ->
                    "#729cfb"

                Red ->
                    "#ff7979"
        )
        >> Maybe.withDefault "#fff"
        >> cellTemplate


renderGrid : Grid -> Html GameMsg
renderGrid grid =
    if Array.isEmpty grid then
        Html.text "empty grid"

    else
        Html.div
            [ Attr.style "display" "grid"
            , Attr.style "grid-template-columns" ("repeat(" ++ String.fromInt gridSize ++ ", 3em)")
            , Attr.style "grid-template-rows" ("repeat(" ++ String.fromInt gridSize ++ ", 3em)")
            , Attr.style "gap" "0.1em"
            ]
            (Array.indexedMap renderCell grid |> Array.toList)


getNeighbours : Int -> Color -> Grid -> List Int
getNeighbours position color grid =
    let
        nearPositions =
            [ position + 1
            , position - 1
            , position - gridSize
            , position + gridSize
            ]

        isNotWrapped pos =
            (modBy gridSize pos == modBy gridSize position)
                || (pos // gridSize == position // gridSize)

        hasSameColor pos =
            Array.get pos grid
                |> Maybe.withDefault Nothing
                |> Maybe.andThen
                    (\col ->
                        if col == color then
                            Just pos

                        else
                            Nothing
                    )
    in
    List.filter isNotWrapped nearPositions
        |> List.filterMap hasSameColor


clearCell : Int -> List Int -> Color -> Grid -> Grid
clearCell position neighbours color grid =
    List.foldl
        (\pos ->
            \gr ->
                let
                    gridWithoutCell =
                        Array.set pos Nothing gr

                    nextNeighbours =
                        getNeighbours pos color gridWithoutCell
                in
                clearCell pos nextNeighbours color gridWithoutCell
        )
        (Array.set position Nothing grid)
        neighbours


shiftColumnDown : Int -> Int -> Grid -> Grid
shiftColumnDown position shift grid =
    Array.get position grid
        |> Maybe.map
            (\cell ->
                Array.set (position + shift * gridSize) cell grid
                    |> shiftColumnDown (position - gridSize) shift
            )
        |> Maybe.withDefault (Array.set (position + gridSize) Nothing grid)


collapseColumn : Int -> Grid -> Grid
collapseColumn position grid =
    let
        shiftOrNot : Cell -> Cell -> Grid
        shiftOrNot cell cellAbove =
            case cell of
                Nothing ->
                    case cellAbove of
                        Nothing ->
                            if (position - gridSize) < gridSize then
                                grid

                            else
                                collapseColumn (position - gridSize) grid

                        _ ->
                            shiftColumnDown (position - gridSize) 1 grid

                _ ->
                    grid
    in
    Maybe.map2
        shiftOrNot
        (Array.get position grid)
        (Array.get (position - gridSize) grid)
        |> Maybe.withDefault grid


collapseGrid : Grid -> Grid
collapseGrid grid =
    let
        positions x =
            List.range 1 (gridSize - 1) |> List.map (\y -> x + gridSize * y)
    in
    List.foldl
        (\x -> \grid2 -> List.foldr collapseColumn grid2 (positions x))
        grid
        (List.range 0 (gridSize - 1))


clearArea : Int -> Grid -> Grid
clearArea position grid =
    Array.get position grid
        |> Maybe.withDefault Nothing
        |> Maybe.map
            (\color ->
                let
                    neighbours =
                        getNeighbours position color grid
                in
                if List.isEmpty neighbours then
                    grid

                else
                    clearCell position neighbours color grid |> collapseGrid
            )
        |> Maybe.withDefault grid
