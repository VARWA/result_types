# Contributing

Thanks for your interest in improving `result_types`.

## Development setup

```bash
dart pub get
dart format .
dart analyze
dart test
```

## Pull request checklist

- Keep API changes backward-compatible where possible
- Add or update tests for behavior changes
- Keep public APIs documented
- Ensure CI passes (`format`, `analyze`, `test`, `pub publish --dry-run`)
