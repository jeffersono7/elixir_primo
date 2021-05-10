defmodule ElixirPrimo.DivisorTest do
  use ExUnit.Case, async: true

  alias ElixirPrimo.Divisor

  describe "is_divisivel/2" do
    test "quando for informado o dividendo e divisor, deve retornar se é divisivel com resto 0" do

      assert true == Divisor.is_divisivel(10, 2)
      assert false == Divisor.is_divisivel(10, 3)
    end
  end
end
