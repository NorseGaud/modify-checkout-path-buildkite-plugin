# Modify BUILDKITE_BUILD_CHECKOUT_PATH

A [Buildkite plugin](https://buildkite.com/docs/agent/v3/plugins) to modify what BUILDKITE_BUILD_CHECKOUT_PATH is set to using a `sed` pattern.

## Example

- `?` is the separator for sed

```yml
steps:
  - plugins:
      - NorseGaud/modify-checkout-path#v0.0.1:
          pattern: "path/to/replace?path/we/want"
```

Original: `/this/is/a/path/to/replace`
Modified: `/this/is/a/path/we/want`

## Tests

To run the tests of this plugin, run
```sh
docker-compose run --rm tests
```

## License

MIT (see [LICENSE](LICENSE))
