defmodule ElixirPrimo.Primo do
  import ElixirPrimo.Divisor, only: :functions

  def start do
    spawn_link(&calcular_numero/0)
  end

  defp calcular_numero do
    receive do
      {source, numero} ->
        result = is_primo(numero)

        send(source, {numero, result})

        calcular_numero()
    end
  end

  defp is_primo(0), do: false
  defp is_primo(1), do: false

  defp is_primo(numero) do
    raiz_numero = :math.sqrt(numero) |> round()

    quantidade_divisivel =
      1..raiz_numero
      |> Enum.map(fn num ->
        Task.async(fn -> is_divisivel(numero, num) end)
      end)
      |> Enum.map(&Task.await(&1))
      |> Enum.filter(& &1)
      |> Enum.count()

    quantidade_divisivel == 1
  end
end
