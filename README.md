# Word Processor CLI

## Description

This is a command-line interface (CLI) for a simple word processor implemented in Elixir. The word processor provides basic functionality such as inserting, deleting, replacing, searching, and displaying text. The application is structured using a GenServer to manage the state of the text.

## How to Run the CLI

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/your-username/word_processor.git
   cd word_processor
   ```

2. **Install Dependencies:**
   Ensure that you have Elixir installed on your machine. Install dependencies by running:
   ```bash
   mix deps.get
   ```

3. **Run the CLI:**
   Start the CLI with the following command:
   ```bash
   iex -S mix
   ```
   This initializes the GenServer and presents a menu for interacting with the word processor.

4. **Interact with the CLI:**
   Follow the menu prompts to perform operations like inserting, deleting, replacing, searching, and displaying text.

5. **Exit the CLI:**
   To exit the CLI, choose option 6 in the menu.

## How to Run Tests

Tests are included to ensure the functionality of the word processor. Run the tests with:
```bash
mix test
```
This command executes the test suite and provides information about the test results.

## Application Structure

- `lib/word_processor.ex`: Contains the implementation of the GenServer for managing the text state and text manipulation functions.

- `lib/word_processor_cli.ex`: Implements the CLI interface, handling user input and interacting with the GenServer.