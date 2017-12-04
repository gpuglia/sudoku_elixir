defmodule SudokuElixir.Game do
  def solve(board) do
    cond do
      SudokuElixir.Board.solved?(board) -> board
      SudokuElixir.Board.valid?(board) -> true
        # move
      true -> nil
    end

    # if Board.valid?(board) do
    #   for move <- Enum.to_list(1..board.board_size) do
    #     board
    #     |> Board.move(move, cell)
    #     |> solve
    #   end
    # end
  end
end
