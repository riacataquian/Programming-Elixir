defmodule SpawnLinken do
  require Logger
  import :timer, only: [ sleep: 1 ]

  def run do
    Enum.each(1..10, fn num ->
      spawn_link(__MODULE__, :some_function, [self, num])
      sleep 500

      receive do
        msg ->
          Logger.info "RECEIVED: " <> inspect msg
      end
    end)
  end

  def some_function(pid, num) do
    Logger.debug "Received #{num} from: #{inspect pid}"
    send pid, num + 1
  end
end
