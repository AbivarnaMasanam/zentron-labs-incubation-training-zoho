# Code.require_file("../BinarySearch.ex")

defmodule UserInputModule do
  def get_input(promt) do
    input =
      IO.gets(promt)
      |> String.trim()

    case String.downcase(input) do
      "exit" ->
        IO.puts("Exiting the Program....\n Exited")
        System.halt(0)

      _ ->
        case Integer.parse(input) do
          {number, ""} when number > 0 ->
            number

          _ ->
            IO.puts(
              "Invalid Input!, Enter the correct input, Enter \"Exit\" to Exit form the Program"
            )

            IO.puts("=======================================\n")
            get_input(promt)
        end
    end
  end

  def ask_input(input) do
    numbers =
      Enum.map(1..input, fn i ->
        get_input("Enter number #{i}: ")
      end)

    # here, i return the Map to the caller....
    numbers
  end

  def calling_fun do
    # here, we are the function to ge the total number input and get the input one by one, print on the
    # consloe using the inspect.....
    mapValue = ask_input(get_input("Enter How Many you want: "))
    targetValue = get_input("Enter the Target Value: ")
    IO.puts(BinarySearch.search(mapValue, targetValue))
  end
end

UserInputModule.calling_fun()
