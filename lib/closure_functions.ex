defmodule ClosureFunctions do

  def reflexive(relations,index\\0) do
    # Receives a list of lists representing a relation R, [[1,2],[3,6]]
    # Return a list which is the reflexive closure of the relation R
    fetch = Enum.fetch(relations,index)
    case fetch do
      :error -> relations #If we are at the end of the list, end here
      {:ok,element} ->
        [a,b] = element
        # Since a and b are in the list, we want to add [a,a] and [b,b], if they don't exist already.
        # Note: Since we are preppending with [a,a]|relations we need idx+1 to remain on the same element
        cond do
          not Enum.member?(relations,[a,a]) -> reflexive([ [a,a] | relations],index+1)
          not Enum.member?(relations,[b,b]) -> reflexive([ [b,b] | relations],index+1)
          true -> reflexive(relations,index+1) #If [a,a] and [b,b] already exist, we move on to the next element.
        end
    end
  end

  def check(tuple,right) do
    Enum.fetch(tuple,1)==right
  end

  def transitive(relations,idx\\0) do
    fetch = Enum.fetch(relations,idx)
    # We will work on the element [a,b] located at idx
    case fetch do
      :error -> relations # In case idx is out of bounds, end here
      {:ok,list} ->
        [a,b] = list
        # Since [a,b] exists, we need to find [b,c] in the list, so we can add [a,c].
        # We add a condition to ignore [b,c] if [a,c] already exists, so we don't get stuck in loops.

        # elementBC = [b,c]
        elementBC = Enum.find(relations,:notfound, fn e ->
          [x,y] = e
          (x == b and not Enum.member?(relations,[a,y])) end )

        cond do
          elementBC==:notfound -> transitive(relations,idx+1) #if there is no [b,c], end here and go the element in idx+1
          true ->
            [_,y] = elementBC
            transitive(  relations ++ [[a,y]] ,idx+1) #Add [a,c] to list
        end
    end
  end
end



input = [
  [1,2],
  [2,2],
  [2,3],
  [3,4],
  [3,4],
  [4,8],
  [10,24]
]


IO.inspect(ClosureFunctions.transitive(input))
