# https://adventofcode.com/2024/day/1

defmodule Mod do
  def get_total_distance(filename) do
    numbers =
      File.read(filename)
      |> get_number_stream()

    left_part =
      Stream.take_every(numbers, 2)
      |> Enum.sort()

    right_part =
      Stream.drop_every(numbers, 2)
      |> Enum.sort()

    Stream.zip_with(left_part, right_part, fn a, b -> abs(a - b) end)
    |> Enum.sum()
  end

  defp get_number_stream({:ok, file_contents}) do
    String.split(file_contents)
    |> Stream.map(&String.to_integer/1)
  end

  defp get_number_stream({:error, reason}) do
    raise("Could not load file reason: #{reason}")
  end
end

Mod.get_total_distance("./input.txt")
|> IO.puts()
