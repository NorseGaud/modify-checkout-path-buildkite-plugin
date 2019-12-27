# Modify BUILDKITE_BUILD_CHECKOUT_PATH

A [Buildkite plugin](https://buildkite.com/docs/agent/v3/plugins) to modify what BUILDKITE_BUILD_CHECKOUT_PATH is set to using `sed`.

## Example

```yml
steps:
  - plugins:
      - NorseGaud/modify-checkout-path#v0.0.1: ~
```

```yml
steps:
  - plugins:
      - thedyrt/modify-checkout-path#v0.0.1:
          cd: /mnt/data
```

## Tests

To run the tests of this plugin, run
```sh
docker-compose run --rm tests
```

## License

MIT (see [LICENSE](LICENSE))
