defmodule Sequence do
  use GenServer
  require Logger

  def start_link(initial_state) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def next_number do
    GenServer.call(__MODULE__, :next_number)
  end

  def increment_number(delta) do
    GenServer.cast(__MODULE__, {:increment_number, delta})
  end

  def terminate(reason, state) do
    Logger.error("#{inspect reason}")
    Logger.error("#{inspect state}")
  end

  def handle_call(:next_number, _sender, state) do
    Logger.warn "State: #{state}"
    {:reply, state, state + 1, :hibernate}
  end

  def handle_cast({:increment_number, delta}, current_number) do
    {:noreply, current_number + delta}
  end

  def format_status(_reason,  [_pdict | state]) do
    [data: [{'State', "My current state is #{inspect state} and Im happy"}]]
  end
end
