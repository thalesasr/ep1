defmodule ClosureFunctionsTest do
  use ExUnit.Case
  doctest ClosureFunctions

  test "Test1 reflexive function" do
    input = [
      [1,6],
      [1,2],
      [2,3],
      [4,4], ##ja reflexivo
      [5,7]
    ]
    expected =Enum.sort(
      [
        [1, 6],
        [1, 2],
        [2, 3],
        [4, 4],
        [5, 7],

        [1, 1], #Adiocionando as reflexoes que nao estavam no input,
        [2, 2],
        [3, 3],
        [5, 5],
        [6, 6],
        [7, 7]
      ])

    output = Enum.sort(ClosureFunctions.reflexive(input))
    assert output==expected

  end

  test "Test1 trantitive function " do
    input = [
      [1,2],
      [2,3],
      [3,4]
    ]
    expected =Enum.sort(
      [
        [1,2],
        [2,3],
        [3,4],

        # Transitividade para o elemento 1
        [1,3],
        [1,4],

        # Transitividade para o elemento 2
        [2,4]
      ])

    output = Enum.sort(ClosureFunctions.transitive(input))
    assert output==expected

  end

  test "Test2 trantitive function " do
    input = [
      [1,2],
      [2,2],
      [2,3],

      [3,4], # Repetido
      [3,4],

      [4,8],

      [10,24] # Isolado
    ]

    expected =Enum.sort(
      [
        [1,2],
        [2,2],
        [2,3],

        [3,4],
        [3,4],

        [4,8],

        [10,24],

        # Transitividade para o elemento 1
        [1,3],
        [1,4],
        [1,8],

        # Transitividade para o elemento 2
        [2,4],
        [2,8],

        # Transitividade para o elemento 3
        [3,8]

      ])

    output = Enum.sort(ClosureFunctions.transitive(input))
    assert output==expected
  end




end
