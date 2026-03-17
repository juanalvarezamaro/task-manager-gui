# Task Manager GUI

A modern web-based task management interface built with Phoenix and Elixir.

## System Requirements

- Elixir 1.15 or later
- Erlang/OTP 26 or later
- Phoenix 1.7 or later
- PostgreSQL 14 or later
- Node.js 18 or later (for asset compilation)

## Development Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/task-manager-gui.git
   cd task-manager-gui
   ```

2. Install dependencies:
   ```bash
   mix deps.get
   mix deps.compile
   ```

3. Setup the database:
   ```bash
   mix ecto.setup
   ```

4. Install Node.js dependencies:
   ```bash
   cd assets
   npm install
   cd ..
   ```

5. Start the Phoenix server:
   ```bash
   mix phx.server
   ```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Local Configuration

1. Create a `.env` file in the root directory:
   ```bash
   cp .env.example .env
   ```

2. Update the environment variables in `.env` with your local settings.

3. Database configuration can be found in `config/dev.exs`. Modify as needed.

## Running Tests

```bash
mix test
```

To run tests with coverage:
```bash
mix test --cover
```

## Code Quality

We use several tools to maintain code quality:

- `mix format` - Code formatting
- `mix credo` - Static code analysis
- `mix dialyzer` - Static type checking
- `mix test` - Automated tests

Run them all with:
```bash
mix check
```

## Documentation

Generate documentation locally:
```bash
mix docs
```

Then open `doc/index.html` in your browser.

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.