defmodule BinarySearch do
  def search(list,target) do
    binarySearch(list,target,0,length(list)-1)
  end

  defp binarySearch(_list, _target, left, right) when left > right do
    -1
  end

  defp binarySearch(list,target,left,right) do
    mid = div(left+right,2)
    value = Enum.at(list,mid)

      cond do
        value == target ->
          mid

        target < value ->
          binarySearch(list,target,left,mid-1)

        target > value ->
          binarySearch(list, target,mid+1,right)
      end
  end

end
