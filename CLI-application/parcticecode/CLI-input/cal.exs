[operator, first, second] = System.argv()

first = String.to_integer(first)
second = String.to_integer(second)

case operator do
  "add" ->
    IO.puts(first + second)

  "sub" ->
    IO.puts(first - second)

  "mul" ->
    IO.puts(first * second)

  _ ->
    IO.puts("Invalid operator!....")
end
