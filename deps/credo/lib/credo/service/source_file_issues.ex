defmodule Credo.Service.SourceFileIssues do
  use GenServer

  alias Credo.SourceFile

  def start_link(opts \\ []) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def append(%SourceFile{filename: filename}, issue) do
    GenServer.call(__MODULE__, {:append, filename, issue})
  end

  def get(%SourceFile{filename: filename}) do
    GenServer.call(__MODULE__, {:get, filename})
  end

  def update_in_source_files(source_files) do
    source_files
    |> Enum.map(&Task.async(fn ->
        %SourceFile{&1 | issues: get(&1)}
      end))
    |> Enum.map(&Task.await(&1, 30_000))
  end

  # callbacks

  def init(_) do
    {:ok, %{}}
  end

  def handle_call({:append, filename, issue}, _from, current_state) do
    issues = List.wrap(current_state[filename])
    new_issue_list = [issue] ++ issues
    new_current_state = Map.put(current_state, filename, new_issue_list)

    {:reply, new_issue_list, new_current_state}
  end

  def handle_call({:get, filename}, _from, current_state) do
    {:reply, List.wrap(current_state[filename]), current_state}
  end
end
