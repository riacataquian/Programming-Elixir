# Nodes

1. Initialize two mix servers.

```sh
iex --sname first_node
```

```sh
iex --sname second_node
```

2. On your first node:
```sh
iex> Node.connect(:"second_node@MacBook-Pro")
iex> :global.register_name(:first_node, :erlang.group_leader)
```

3. On your second node:
```sh
iex> first_node_pid = :global.whereis_name(:first_node)
iex> IO.puts(first_node_pid, "Hello")
iex> IO.puts(first_node_pid, "World")
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add nodes to your list of dependencies in `mix.exs`:

        def deps do
          [{:nodes, "~> 0.0.1"}]
        end

  2. Ensure nodes is started before your application:

        def application do
          [applications: [:nodes]]
        end

