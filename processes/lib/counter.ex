defmodule Counter do
  require Logger

  def run(count) do
    Logger.debug "Spawning #{count} processes"

    {duration, result} = :timer.tc(Counter, :counter, [count])
    Logger.info "Duration is: " <> inspect duration
    Logger.warn inspect result
  end

  def counter(count) do
    processes =
      Enum.reduce(1..count, self, fn _num, receiver ->
        IO.puts "self: #{inspect self}"
        IO.inspect receiver
        spawn(Counter, :increment, [receiver])
      end)

    IO.puts "last: #{inspect processes}"
    send processes, count
    receive do
      total -> "Result is #{total}"
    end
  end

  def increment(pid) do
    receive do
      num -> # HAO
        IO.puts "#{inspect self} - #{inspect num}"
        send pid, num + 1
    end
  end
end

#process = spawn fn -> Counter.increment pid end # self
#process2 = spawn fn -> Counter.increment pid end # process

#send process2, 1

