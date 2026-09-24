defmodule stringAnalyzer do

  def analyze(inputString) do
    if inputString =""
    %{:error,"Empty String"}
  else
    length = String.length(inputString)
    uppperCase = String.to_upcase(inputString)
    lowerCase  = String.to_locase(inputString)
    %{length: length,uppperCase: uppperCase, lowerCase: lowerCase}

  end

  # def firstword(inputString) do

  # end



end
