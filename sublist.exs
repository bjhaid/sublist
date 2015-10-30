defmodule Sublist do
  def compare(l,l), do: :equal
  def compare([],[_|_]), do: :sublist
  def compare(l,[_|l]), do: :sublist
  def compare([_|_],[]), do: :superlist
  def compare([_|l],l), do: :superlist
  def compare(x,y) do
    compare_list(x,y)
  end

  defp compare_list(y,y), do: :equal
  defp compare_list(x,[_|z] = y) when length(x) < length(y) do
    case (Enum.chunk(y, length(x)) |> hd) === x do
      true -> :sublist
      _    -> case compare_list(x,z) do
        :sublist -> :sublist
        :equal -> :sublist
        _      -> :unequal
      end
    end
  end
  defp compare_list([_|z] = x,y) when length(x) > length(y) do
    case (Enum.chunk(x, length(y)) |> hd) === y do
      true -> :superlist
      _    -> case compare_list(z,y) do
        :superlist -> :superlist
        :equal -> :superlist
        _      -> :unequal
      end
    end
  end
  defp compare_list(_,_), do: :unequal
end
