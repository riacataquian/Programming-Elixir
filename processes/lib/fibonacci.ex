defmodule Fibonacci do
  def gora(process_count, module, fun, to_calculate) do
    1..process_count
    |> Enum.map(fn _item -> spawn(module, fun, [self]) end)
    |> schedule(to_calculate, [])
  end

  defp schedule(processes, queue, results) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        [ next | tail ] = queue
        send pid, {:fib, next, self}
        schedule(processes, tail, results)
      {:ready, pid} ->
        send pid, {:shutdown}
        if length(processes) > 1 do
          schedule(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
        end
      {:answer, number, result, _pid} ->
        schedule(processes, queue, [ {number, result} | results ])
    end
  end

  def run do
    to_process = [37, 37, 37, 37, 37, 37, 37, 37]

    Enum.each 1..10, fn num ->
      {time, result} = :timer.tc(Fibonacci, :gora, [num, FibSolver, :fib, to_process])
      if num == 1 do
        IO.puts inspect result
        IO.puts "\n # time (s)"
      end
      :io.format("~2B ~.2f~n", [num, time/1000000.0])
    end
  end
end
