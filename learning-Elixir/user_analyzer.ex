defmodule UserAnal do
  def checkuname(user) do
    %{name: name, age: age, role: role, active: active} = user

    if active do
      {:ok, "Abivarna is an active Developer"}
    else
      {:error, "User is inactive"}
    end
  end
end
