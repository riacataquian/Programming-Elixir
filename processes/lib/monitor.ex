defmodule Monitor do
  require Logger
  import :timer, only: [ sleep: 1 ]

  def sad_function do
    sleep 500
    exit :boom
  end

  def run do
    res = spawn_monitor(__MODULE__, :sad_function, [])
    Logger.debug inspect res

    receive do
      msg ->
        Logger.info "MESSAGE RECEIVED: " <> inspect msg
      after 1000 ->
        Logger.warn "Nope, nothing happened !sad"
    end
  end
end
