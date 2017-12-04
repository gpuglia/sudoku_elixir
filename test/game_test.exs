defmodule GameTest do
  use ExUnit.Case
  doctest SudokuElixir

  import SudokuElixir.Game, only: [solve: 1]

  test "solve returns a solved board" do
    board = SudokuElixir.Board.to_board("147382829")
    assert solve(board) == true
  end
end
