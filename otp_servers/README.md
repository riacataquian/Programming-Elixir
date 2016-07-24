# OtpServers

## Sequence

1. Run your server:
```sh
iex -s mix
```

2. Start the GenServer by calling `start_link/1` on Sequence module,
passing an initial state.

```sh
Sequence.start_link(10)
```

3. Call `next_number/0` and `increment_number/1` within Sequence module.

You may also want to terminate your GenServer by running:
```sh
GenServer.stop(Sequence)
```

Get the GenServer's PID by running:
```sh
GenServer.whereis(Sequence)
```


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add otp_servers to your list of dependencies in `mix.exs`:

        def deps do
          [{:otp_servers, "~> 0.0.1"}]
        end

  2. Ensure otp_servers is started before your application:

        def application do
          [applications: [:otp_servers]]
        end

