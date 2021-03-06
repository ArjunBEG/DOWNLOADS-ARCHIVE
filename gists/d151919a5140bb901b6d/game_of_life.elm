import Debug
import Window

data State = Dead | Alive
data Condition = Underpopulation | Overcrowding | Reproduction | Stable
type Cell = {x:Int, y:Int, state:State}
type Game = {cells: [Cell]}

black = rgb 0 0 0

-- Helpers

flatten : [[a]] -> [a]
flatten list =
  foldl (++) [] list

inRange : Int -> Int -> Int -> Bool
inRange x y dim2 =
  x >= 1 && y >= 1 &&
  x <= sqrt (toFloat dim2) && y <= sqrt (toFloat dim2)

-- Game

alive = [[1,1], [1,2], [2,1]]

initGame : (Int, Int) -> Game
initGame (rows, cols) =
  {cells = flatten <| map (\row ->
                             map (\col -> {x = row, y = col, state = (initCell row col)}) [1..cols])
                      [1..rows]}

updateGame : Float -> Game -> Game
updateGame timestamp game =
  {cells = map (\cell -> updateCell cell game) game.cells}

getCell : Game -> Int -> Int -> Cell
getCell game x y =
  head <| filter (\cell -> cell.x == x && cell.y == y) (game.cells)

-- Cell

initCell : Int -> Int -> State
initCell row col =
  case (any (\[x,y] -> x == row && y == col) alive) of
    True -> Alive
    False -> Dead

updateCell : Cell -> Game -> Cell
updateCell cell game =
  {cell | state <- case cellCondition <| neighbours cell game of
                     Underpopulation -> Dead
                     Overcrowding -> Dead
                     Reproduction -> Alive
                     Stable -> Alive}

neighbours : Cell -> Game -> [Cell]
neighbours cell game =
  map (\(x,y) -> getCell game x y) <| filter (\(x,y) -> inRange x y (length game.cells))
                                              [(cell.x - 1, cell.y - 1),
                                               (cell.x, cell.y - 1),
                                               (cell.x + 1, cell.y - 1),
                                               (cell.x - 1, cell.y),
                                               (cell.x + 1, cell.y),
                                               (cell.x - 1, cell.y + 1),
                                               (cell.x, cell.y + 1),
                                               (cell.x + 1, cell.y + 1)]

cellCondition : [Cell] -> Condition
cellCondition neighbours =
  let aliveNeighbours = length <| filter (\cell -> cell.state == Alive) neighbours in
  if | aliveNeighbours < 2 -> Underpopulation
     | aliveNeighbours == 2 -> Stable
     | aliveNeighbours > 3 -> Overcrowding
     | aliveNeighbours == 3 -> Reproduction

-- View

gameSize = (20, 20)
cellSize = 20

displayCell : Cell -> Int -> Form
displayCell cell size =
  rect (toFloat size) (toFloat size) |> filled (case cell.state of
                                                  Dead -> white
                                                  Alive -> black)
                                     |> move (toFloat <| cell.x * size, toFloat <| -cell.y * size)

display : Game -> (Int, Int) -> Element
display game (w, h) =
  let gameWidth = (fst gameSize) * cellSize
      gameHeight = (snd gameSize) * cellSize
  in
    container w h middle <|
    collage w h
              [
               rect (gameWidth + cellSize) (gameHeight + cellSize) |> outlined (solid black),
               group (map (\cell -> displayCell cell cellSize) game.cells) |> move (-gameWidth / 2, gameHeight / 2)
              ]

gameState : Signal Game
gameState = foldp updateGame (initGame gameSize) (every second)

main = lift2 display gameState Window.dimensions
