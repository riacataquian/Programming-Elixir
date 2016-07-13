defmodule Pmap do
  require Logger

  def run(collection, fun) do
    {pduration, presult} = :timer.tc(__MODULE__, :parallel, [collection, fun])
    {duration, result} = :timer.tc(__MODULE__, :map, [collection, fun])

    Logger.info "Parallel Duration is: #{inspect pduration} with #{inspect presult} as result."
    Logger.info "Map Duration is: #{inspect duration} with #{inspect result} as result."
  end

  def map(collection, fun) do
    Enum.map(collection, fn item -> fun.(item) end)
  end

  def parallel(collection, fun) do
    this = self

    collection
    |> Enum.map(fn item -> spawn_link(fn -> send this, {self, fun.(item)} end) end)
    |> Enum.map(fn pid ->
      receive do
        {^pid, result} ->
          Logger.warn "Running #{inspect pid}.. Results to: #{inspect result}"
        after 1000 ->
          Logger.error "Something went wrong"
      end
    end)
  end
end
