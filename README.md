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

### Support for Interpolation

- if `cleanup` is set to true, it will delete the directory it cloned into as part of the pre-exit hook

```yml
steps:
  - plugins:
      - NorseGaud/modify-checkout-path#v0.0.1:
          pattern: "$${BUILDKITE_AGENT_NAME}?$BUILDKITE_BUILD_ID"
          cleanup: true
```

Original: `/home/kubernetes/flexvolume/buildkite/builds/buildkite-eks-agents-builder-b6n5r-t44-1/REPO`
Modified: `/home/kubernetes/flexvolume/buildkite/builds/a81c5691-bd5e-4fb6-960e-11e60901b965/REPO`

## Tests

To run the tests of this plugin, run
```sh
docker-compose run --rm tests
```

## License

MIT (see [LICENSE](LICENSE))
