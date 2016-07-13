defmodule Loop do
  def greet do
    receive do
      {sender, message} ->
        send sender, {:ok, "Halo #{message}"}
    end

    greet
  end
end

defmodule Client do
  def run do
    pid = spawn(Loop, :greet, [])
    send pid, {self, "jarjar"}
    send pid, {self, "theo"}

    receive do
      {:ok, message} ->
        IO.puts message
    end

    receive do
      {:ok, message} ->
        IO.puts "Another message: " <> message
      after 500 ->
        IO.puts "so long"
    end
  end
end

