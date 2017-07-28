defmodule Issues do
  def run do
    IO.puts "Requesting for issues on elixir-lang..."
    {:ok, issues} = Issues.CLI.main(["elixir-lang", "elixir", "5"])
    IO.inspect issues
  end

  def run(:help) do
    Issues.CLI.main([:help])
  end
end
