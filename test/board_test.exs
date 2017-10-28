defmodule BoardTest do
  use ExUnit.Case
  doctest SudokuElixir

  import SudokuElixir.Board, only: [valid?: 1, to_list: 1, rows: 1, columns: 1, boxes: 1]
  # test "valid? when rows, columns and boxes have valid numbers" do
  #   board = %SudokuElixir.Board{cells: "417369825632158947958724316825437169791586432346912758289643571573291684164875293" }
  #   assert valid?(board) == true
  # end

  test "to_list returns a list of cells" do
    board = %SudokuElixir.Board{cells: "147382829"}
    assert to_list(board) == [1, 4, 7, 3, 8, 2, 8, 2, 9]
  end

  test "rows splits the board into rows according to the board size" do
    board = %SudokuElixir.Board{cells: "147382829", board_size: 3}
    assert rows(board) == [[1, 4, 7], [3, 8, 2], [8, 2, 9]]
  end

  test "columns splits the board into columns according to the board size" do
    board = %SudokuElixir.Board{cells: "147382829", board_size: 3}
    assert columns(board) == [[1, 3, 8], [4, 8, 2], [7, 2, 9]]
  end

  test "boxes splits the board into boxes according to the board size" do
    board = %SudokuElixir.Board{cells: "1473820297389260", board_size: 4}
    assert boxes(board) == [[1, 4, 8, 2], [7, 3, 0, 2], [9, 7, 9, 2], [3, 8, 6, 0]]
  end
end
