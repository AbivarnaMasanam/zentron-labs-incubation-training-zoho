# This is parctice code on 30th sep and 1st oct 2026. This help to learn about the user input modelu
# and run the program on the user input data... using IO.gets()

# ---------Get the input for the User--------
# ts = IO.gets("")
# IO.puts("You entered: #{ts}")

# ------Get the input convert to integer-------
# ts =
#   IO.gets("Enter how many number you want: ")
#   |> String.trim()
#   |> String.to_integer()

# IO.puts(ts)

# ------Get the input using the Function()

# defmodule Getinput do
#   def run do
#     "How many numbers do you want to insert? "
#     |> IO.gets()
#     |> String.trim()
#     |> String.to_integer()
#   end
# end

# ----Get the input verif its only a interger & convert to interger
# return the success message----

# input =
#   IO.gets("Enter how many numbers you want: ")
#   |> String.trim()

# case Integer.parse(input) do
#   {number, ""} ->
#     IO.puts("You entered: #{number}")

#   _ ->
#     IO.puts("Invalid input! Please enter a number.")
# end
Code.require_file("UserInputModule.exs")

UserInputModule.calling_fun()
