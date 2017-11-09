defmodule SudokuElixir.Board do
  defstruct cells: [], board_size: 9

  def to_board(string, size \\ 9) do
    %SudokuElixir.Board{cells: to_list(string), board_size: size}
  end

  def complete?(board) do
  end

  def valid?(board) do
    [rows(board), columns(board), boxes(board)]
    |> Enum.all?(&valid_group?(&1))
  end

  def move(board, cell, value) do
    board.cells
    |> List.replace_at(cell, value)
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

  defp to_list(board_string) do
    board_string
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer(&1))
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
    board.cells
    |> Stream.with_index
    |> Enum.group_by(
      fn {_, index} -> group_function.(index) end,
      fn {cell, _} -> cell end)
  end

  defp valid_group?(groups) do
    groups
    |> Enum.all?(
      fn {_, group} -> group == Enum.uniq(group) end
    )
  end
end
