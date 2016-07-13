defmodule Sad do
  require Logger
  import :timer, only: [ sleep: 1 ]

  def exit_process do
    sleep 500
    exit(:boom)
  end

  def run do
    Process.flag(:trap_exit, true)
    spawn_link(__MODULE__, :exit_process, [])
    receive do
      msg ->
        Logger.info "Message received: #{inspect msg}"
      after 100 ->
        Logger.warn "Nothing happened, I'm saddened"
    end
  end
end
