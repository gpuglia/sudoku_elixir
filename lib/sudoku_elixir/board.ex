defmodule SudokuElixir.Board do
  defstruct cells: "", board_size: 9

  def valid?(board) do
    valid_group?(rows(board))
  end

  def to_list(board) do
    board.cells
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer(&1))
  end

  def rows(board) do
    groups(board, &row_index(board, &1))
  end

  def columns(board) do
    groups(board, &column_index(board, &1))
  end

  def boxes(board) do
    groups(board, &box_index(board, &1))
  end

  defp row_index(board, index), do: div(index, board.board_size)

  defp column_index(board, index), do: rem(index, board.board_size)

  defp box_index(board, index) do
    box_size = round(:math.sqrt(board.board_size))
    box_row = row_index(board, index) |> div(box_size)
    box_column = column_index(board, index) |> div(box_size)

    (3 * box_row) + box_column
  end

  defp groups(board, group_function) do
    board
    |> to_list
    |> Stream.with_index
    |> Enum.group_by(
      fn {_, index} -> group_function.(index) end,
      fn {cell, _} -> cell end)
    |> Map.values
  end

  defp valid_group?(groups) when is_list(groups) do
    Enum.all?(groups, &valid?(Enum.sort(&1)))
  end
  defp valid_group?(1..9), do: true
  defp valid_group?(_), do: false
end
