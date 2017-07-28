defmodule Issues.Github do
  @user_agent  [ {"User-agent", "Elixir ria.cataquian@gmail.com"} ]
  @github_url Application.get_env(:issues, :github_url)

  @doc """
  Accepts two parameter: `user` and `project`.
  Requests issues from the given project name.

  ## Example:

      iex> Issues.Github.get("elixir-lang", "elixir")
  """
  def get(user, project, count) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response(count)
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({:ok, %HTTPoison.Response{body: body}}, count) do
    body =
      body
      |> Poison.decode!()
      |> sort()
      |> Enum.take(count)

    {:ok, body}
  end

  def handle_response({:error, %HTTPoison.Error{reason: reason}}, _count) do
    {:error, reason}
  end

  defp sort(issues) do
    Enum.sort(issues, fn i1, i2 -> i1["created_at"] <= i2["created_at"] end)
  end
end
