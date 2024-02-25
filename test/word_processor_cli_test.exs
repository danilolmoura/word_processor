defmodule WordProcessorCLITest do
  use ExUnit.Case

  setup do
    {:ok, pid} = WordProcessor.start_link()
    {:ok, pid: pid}
  end

  test "inserting text", state do
    pid = state[:pid]
    WordProcessorCLI.insert_menu(pid)
    assert WordProcessor.show(pid) == "inserted text"
  end

  test "deleting text", state do
    pid = state[:pid]
    WordProcessorCLI.insert_menu(pid)  # Insert some text first
    WordProcessorCLI.delete_menu(pid)
    assert WordProcessor.show(pid) == ""
  end

  test "replacing text", state do
    pid = state[:pid]
    WordProcessorCLI.insert_menu(pid)  # Insert some text first
    WordProcessorCLI.replace_menu(pid)
    assert WordProcessor.show(pid) == "replaced text"
  end

  test "searching for text", state do
    pid = state[:pid]
    WordProcessorCLI.insert_menu(pid)  # Insert some text first
    assert WordProcessorCLI.search_menu(pid) == "Text found! It starts in position 0"
  end

  test "showing text", state do
    pid = state[:pid]
    WordProcessorCLI.insert_menu(pid)  # Insert some text first
    assert WordProcessorCLI.show_text(pid) == "inserted text"
  end

  test "exiting program", state do
    pid = state[:pid]
    assert WordProcessorCLI.exit_program(pid) == :ok
  end
end
