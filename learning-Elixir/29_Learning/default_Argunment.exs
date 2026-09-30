defmodule Concat do
  def join(a, b, sep \\ " ") do #=> in this line \\ is the default vaule declaration...
    a <> sep <> b
  end
end

IO.puts(Concat.join("Hello", "world"))      #=> Hello world
IO.puts(Concat.join("Hello", "world", "_")) #=> Hello_world

# other version of code

defmodule DefaultTest do
  def dowork(x \\ "hello") do
    x
  end
end
IO.puts(DefaultTest.dowork()) #Here the default value will work, because we not sent any value to it.
