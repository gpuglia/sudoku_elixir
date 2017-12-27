defmodule BoardTest do
  use ExUnit.Case
  doctest SudokuElixir

  import SudokuElixir.Board, only: [solved?: 1, to_board: 1, to_board: 2, complete?: 1, valid?: 1, rows: 1, columns: 1, boxes: 1, move: 3]
  test "to_board returns a Board when passed a string of cells" do
    assert to_board("147382829")  == %SudokuElixir.Board{cells: [1, 4, 7, 3, 8, 2, 8, 2, 9], board_size: 9}
  end

  test "solved? when the board is complete and valid" do
    board = to_board("417369825632158947958724316825437169791586432346912758289643571573291684164875293")
    assert solved?(board) == true
  end

  test "solved? when the board is complete but not valid" do
    board = to_board("447369825632158947958724316825437169791586432346912758289643571573291684164875293")
    assert solved?(board) == false
  end

  test "solved? when the board is not complete but valid" do
    board = to_board("407369825632158947958724316825437169791586432346912758289643571573291684164875293")
    assert solved?(board) == false
  end

  test "solved? when the board is neither complete nor valid" do
    board = to_board("447369825632158947958724316825437169791586432346912758289643571573291684164875293")
    assert solved?(board) == false
  end

  test "valid? when rows, columns and boxes have valid numbers" do
    board = to_board("140382029", 3)
    assert valid?(board) == true
  end

  test "valid? when any of the rows, columns and boxes don't have valid numbers" do
    board = to_board("144382029", 3)
    assert valid?(board) == false
  end

  test "complete? where the board is complete" do
    board = to_board("147382829", 3)
    assert complete?(board) == true
  end

  test "complete? where the board is not complete" do
    board = to_board("140382029", 3)
    assert complete?(board) == false
  end

  test "rows splits the board into rows according to the board size" do
    board = to_board("147382829", 3)
    assert rows(board) == %{ 0 => [1, 4, 7], 1 => [3, 8, 2], 2 => [8, 2, 9] }
  end

  test "columns splits the board into columns according to the board size" do
    board = to_board("147382829", 3)
    assert columns(board) == %{ 0 => [1, 3, 8], 1 => [4, 8, 2], 2 => [7, 2, 9] }
  end

  test "boxes splits the board into boxes according to the board size" do
    board = to_board("1473820297389260", 4)
    assert boxes(board) == %{ 0 => [1, 4, 8, 2], 1 => [7, 3, 0, 2], 2 => [9, 7, 9, 2], 3 => [3, 8, 6, 0] }
  end

  test "move inserts a number in the corresponding index" do
    board = to_board("1406")
    assert move(board, 2, 7) == %SudokuElixir.Board{cells: [1, 4, 7, 6]}
  end
end
