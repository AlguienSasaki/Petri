defmodule Petri do
  def ex1l do
    [
      [P0, A],
      [P1, B],
      [P1, D],
      [P2, C],
      [P2, D],
      [P3, E],
      [P4, E],
      [A, P1],
      [A, P2],
      [B,P3],
      [C,P4],
      [D,P3],
      [D,P4],
      [E,P5]
    ]
  end

  def ex1m do
    %{
      P0 => MapSet.new([A]),
      P1 => MapSet.new([B,D]),
      P2 => MapSet.new([C,D]),
      P3 => MapSet.new([E]),
      P4 => MapSet.new([E]),
      P5 => MapSet.new([]),
      A => MapSet.new([P1,P2]),
      B => MapSet.new([P3]),
      C => MapSet.new([P4]),
      D => MapSet.new([P3,P4]),
      E => MapSet.new([P5])
    }
  end

def preset(f, n) do
  f
  |> Enum.filter(fn [_a, b] -> b == n end)
  |> Enum.map(fn [a, _b] -> a end)
  |> MapSet.new()
end

def postset(f, n) do
  f
  |> Enum.filter(fn [a, _b] -> a == n end)
  |> Enum.map(fn [_a, b] -> b end)
  |> MapSet.new()
end

def is_enabled(f, n, m)do
    MapSet.subset?(preset(f,n), m)
end

def fire(f, n, m) do
  if is_enabled(f, n, m) do
    m
    |> MapSet.difference(preset(f, n))
    |> MapSet.union(postset(f, n))
  else
    m 
end
end

def enablement_list(f, m) do
  f
  |> List.flatten()
  |> Enum.uniq()
  |> Enum.filter(fn nodo -> !is_place?(nodo) end)
  |> Enum.filter(fn t -> is_enabled(f, t, m) end)
  |> MapSet.new()
end

def enablement_map(mapa, m) do
  mapa
  |> Map.keys()
  |> Enum.filter(fn nodo -> !is_place?(nodo) end)
  |> Enum.filter(fn t -> 
    pre = preset_map(mapa, t)
    MapSet.subset?(pre, m)
  end)
  |> MapSet.new()
end

# Funciones (Indispensables para que compile)

defp is_place?(nodo) do
  nodo |> Kernel.to_string() |> String.contains?("P")
end

defp preset_map(mapa, t) do
  mapa
  |> Enum.filter(fn {_lugar, conexiones} -> MapSet.member?(conexiones, t) end)
  |> Enum.map(fn {lugar, _conexiones} -> lugar end)
  |> MapSet.new()
end
end
