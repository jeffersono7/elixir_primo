defmodule ElixirPrimoTest do
  use ExUnit.Case
  doctest ElixirPrimo

  test "greets the world" do
    assert ElixirPrimo.hello() == :world
  end
end
