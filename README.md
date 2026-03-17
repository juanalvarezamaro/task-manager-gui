# Task Manager GUI

A Phoenix-based web interface for the Task Manager application.

## Requirements

* Elixir 1.14 or later
* Phoenix 1.7.10
* Node.js 16 or later

## Development Setup

1. Install dependencies:
   ```bash
   mix deps.get
   cd assets && npm install
   ```

2. Start Phoenix server:
   ```bash
   mix phx.server
   ```

Visit [`localhost:4000`](http://localhost:4000) from your browser.

## Running Tests

```bash
mix test
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request