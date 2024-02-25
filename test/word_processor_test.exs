defmodule WordProcessorTest do
  use ExUnit.Case
  doctest WordProcessor

  setup do
    {:ok, pid} = WordProcessor.start_link()
    {:ok, pid: pid}
  end


  test "inserts text at the specified position", state do
    pid = state[:pid]
    assert :ok == WordProcessor.insert(pid, 0, "Hello")
    assert "Hello" == WordProcessor.show(pid)
  end

  test "deletes text from the specified position", state do
    pid = state[:pid]
    WordProcessor.insert(pid, 0, "Hello, World!")
    assert :ok == WordProcessor.delete(pid, 5, 7)
    assert "Hello!" == WordProcessor.show(pid)
  end

  test "replaces occurrences of a substring with a new string", state do
    pid = state[:pid]
    WordProcessor.insert(pid, 0, "Hello, World!")
    assert :ok == WordProcessor.replace(pid, "World", "Universe")
    assert "Hello, Universe!" == WordProcessor.show(pid)
  end

  test "searches for a substring and returns its index", state do
    pid = state[:pid]
    WordProcessor.insert(pid, 0, "Hello, World!")
    assert 7 == WordProcessor.search(pid, "World")
  end

  test "search returns -1 if substring is not found", state do
    pid = state[:pid]
    WordProcessor.insert(pid, 0, "Hello, World!")
    assert -1 == WordProcessor.search(pid, "Universe")
  end
end
