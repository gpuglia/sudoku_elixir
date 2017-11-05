defmodule SudokuElixir.Board do
  defstruct cells: "", board_size: 9

  def valid?(board) do
    [rows(board), columns(board), boxes(board)]
    |> Enum.all?(&valid_group?(&1))
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

    (box_size * box_row) + box_column
  end

  defp groups(board, group_function) do
    board
    |> to_list
    |> Stream.with_index
    |> Enum.group_by(
      fn {_, index} -> group_function.(index) end,
      fn {cell, _} -> cell end)
  end

  defp valid_group?(groups) when is_map(groups) do
    Enum.all?(groups, fn {_, group} -> valid_group?(group) end)
  end

  defp valid_group?(group) do
    Enum.sort(group) == Enum.to_list(1..length(group))
  end
end
