defmodule Sequence.Server do
  use GenServer

  def handle_call(:next_number, _sender_pid, current_number) do
    {:reply, current_number, current_number + 1}
  end
end
