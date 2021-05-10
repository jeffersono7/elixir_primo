defmodule ElixirPrimo.PrimoTest do
  use ExUnit.Case, async: true

  import ElixirPrimo.Primo, only: :functions

  describe "start/0" do
    test "deve retornar pid de processo criado" do
      refute nil == start()
    end
  end

  describe "calcular_numero/1" do
    test "deve calcular se 0 é primo" do
      pid = start()

      send(pid, {self(), 0})

      receive do
        {0, false} -> assert true
        _ -> assert false
      end
    end

    test "deve calcular se 1 é primo" do
      pid = start()

      send(pid, {self(), 1})

      receive do
        {1, false} -> assert true
        _ -> assert false
      end
    end

    test "deve calcular que números são primos" do
      pid = start()

      for numero <- [2, 3, 5, 7, 11] do
        send(pid, {self(), numero})

        receive do
          {^numero, true} -> assert true
          _ -> assert false
        end
      end
    end
  end

  test "deve calcular que números não são primos" do
    pid = start()

    for numero <- [0, 1, 4, 6, 8, 9, 10] do
      send(pid, {self(), numero})

      receive do
        {^numero, false} -> assert true
        _ -> assert false
      end
    end
  end
end
