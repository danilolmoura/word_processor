defmodule WordProcessor do
  use GenServer

  # Client API

  @doc "Starts the GenServer"
  def start_link, do: GenServer.start_link(__MODULE__, "")

  @doc "Inserts the given string at the specified position"
  def insert(pid, position, string) do
    GenServer.cast(pid, {:insert, position, string})
  end

  @doc "Deletes a substring starting from the specified position"
  def delete(pid, start, length) do
    GenServer.cast(pid, {:delete, start, length})
  end

  @doc "Replaces occurrences of a substring with a new string"
  def replace(pid, old_substring, new_string) do
    GenServer.cast(pid, {:replace, old_substring, new_string})
  end

  @doc "Searches for a substring and returns its index, or -1 if not found"
  def search(pid, substring) do
    GenServer.call(pid, {:search, substring})
  end

  @doc "Returns the current state of the text"
  def show(pid) do
    GenServer.call(pid, :show)
  end

  # GenServer callbacks

  @doc false
  def init(_args), do: {:ok, ""}

  @doc false
  def handle_cast({:insert, position, string}, state) do
    new_text = insert_text(state, position, string)
    {:noreply, new_text}
  end

  @doc false
  def handle_cast({:delete, start, length}, state) do
    new_text = delete_text(state, start, length)
    {:noreply, new_text}
  end

  @doc false
  def handle_cast({:replace, old_substring, new_string}, state) do
    new_text = replace_text(state, old_substring, new_string)
    {:noreply, new_text}
  end

  @doc false
  def handle_call({:search, substring}, _from, state) do
    result = search_text(state, substring)
    {:reply, result, state}
  end

  @doc false
  def handle_call(:show, _from, state) do
    {:reply, state, state}
  end

  # Helper functions for text manipulation

  @doc false
  defp insert_text(state_text, position, string) do
    {prefix, suffix} = String.split_at(state_text, position)
    prefix <> string <> suffix
  end

  @doc false
  defp delete_text(state_text, start_pos, end_pos) do
    {prefix, suffix} = String.split_at(state_text, start_pos)
    suffix_after_delete = String.slice(suffix, end_pos..String.length(state_text))
    prefix <> suffix_after_delete
  end

  @doc false
  defp replace_text(state_text, old_substring, new_string) do
    :binary.replace(state_text, old_substring, new_string)
  end

  @doc false
  defp search_text(state_text, substring) do
    case :binary.match(state_text, substring) do
      {index, _} -> index
      :nomatch -> -1
    end
  end
end
