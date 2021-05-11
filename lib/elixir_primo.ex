defmodule ElixirPrimo do
  @moduledoc """
  Módulo principal `ElixirPrimo`.
  """

  alias ElixirPrimo.Primo

  def call do
    IO.puts("\n --- Calculamos primos ---\n\n")
    IO.puts("\n[ Para sair digite :sair ]")
    IO.puts("\n[ Digite o número e diremos se é primo ]")

    numero = ler_numero()

    if :sair != numero do
      pid = Primo.start()

      send(pid, {self(), numero})

      receive do
        {_, true} -> IO.puts("É primo!")
        {_, false} -> IO.puts("Não é primo!")
        _ -> IO.puts("Houve um erro!")
      end

      call()
    else
      IO.puts("Bye!")
    end
  end

  def primos_ate(numero) do
    1..numero
    |> Enum.map(fn n ->
      pid = Primo.start()

      send(pid, {self(), n})
    end)
    |> Enum.map(fn _ ->
      receive do
        {n, result} -> {n, result}
      end
    end)
    |> Enum.filter(fn {_n, result} -> result end)
    |> Enum.sort(fn {n1, _result1}, {n2, _result2} -> n1 < n2 end)
    |> Enum.map(fn {n, _result} -> "#{n}" end)
    |> Enum.join(", ")
    |> IO.puts()
  end

  defp ler_numero do
    IO.read(:line)
    |> String.trim()
    |> parse_numero()
  end

  defp parse_numero(numero) do
    IO.inspect(numero)
    with {numero_int, _} <- Integer.parse(numero) do
      numero_int
    else
      _ -> call()
    end
  end
end
