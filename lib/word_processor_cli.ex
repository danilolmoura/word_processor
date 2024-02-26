defmodule WordProcessorCLI do
  def start do
    {:ok, pid} = WordProcessor.start_link()
    menu(pid)
  end

  def menu(pid) do
    IO.puts """

    Word Processor CLI Menu:
    1. Insert
    2. Delete
    3. Replace
    4. Search
    5. Show
    6. Exit
    """

    IO.write("Choose an option: ")
    option = String.trim(IO.gets(""))

    case option do
      "1" -> insert_menu(pid)
      "2" -> delete_menu(pid)
      "3" -> replace_menu(pid)
      "4" -> search_menu(pid)
      "5" -> show_text(pid)
      "6" -> exit_program(pid)
      _ -> IO.puts("Invalid option. Please try again.")
    end

    unless option == "6" do
      menu(pid)
    end
  end

  def insert_menu(pid) do
    position = get_integer_input("Enter position: ")

    IO.write("Enter string to insert: ")
    string = String.trim(IO.gets(""))

    case WordProcessor.insert(pid, position, string) do
      :ok -> IO.puts("Text inserted successfully at position #{position}!")
    end

    menu(pid)
  end

  def delete_menu(pid) do
    start_pos = get_integer_input("Enter start position: ")

    length = get_integer_input("Enter length to delete: ")

    case WordProcessor.delete(pid, start_pos, length) do
      :ok -> IO.puts("Deletion successful!")
    end

    menu(pid)
  end

  def replace_menu(pid) do
    IO.write("Enter old substring to replace: ")
    old_substring = String.trim(IO.gets(""))

    IO.write("Enter new string: ")
    new_string = String.trim(IO.gets(""))

    case WordProcessor.replace(pid, old_substring, new_string) do
      :ok -> IO.puts("Replacement successful")
    end

    menu(pid)
  end

  def search_menu(pid) do
    IO.write("Enter substring to search: ")
    substring = String.trim(IO.gets(""))

    case WordProcessor.search(pid, substring) do
      -1 -> IO.puts("Text not found!")
      pos -> IO.puts("Text found! It starts in position #{pos}")
    end

    menu(pid)
  end

  def show_text(pid) do
    text = WordProcessor.show(pid)
    IO.puts("The current text is: #{text}")
    menu(pid)
  end

  defp exit_program(pid) do
    IO.puts("Exiting...")
    :ok = GenServer.stop(pid)
    :ok = System.halt(0)
  end

  defp get_integer_input(prompt) do
    input = IO.gets(prompt) |> String.trim()

    try do
      String.to_integer(input)
    rescue
      _ ->
        IO.puts("Invalid input. Please enter a valid number.")
        get_integer_input(prompt)
    end
  end
end


WordProcessorCLI.start()
