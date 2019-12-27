#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

tmp_dir=$(mktemp -d -t skip-checkout.XXXXXXXXXX)

function cleanup {
  rm -rf "$tmp_dir"
}
trap cleanup EXIT

environment_hook="$PWD/hooks/environment"

@test "Modify BUILDKITE_BUILD_CHECKOUT_PATH" {
  export TMP_DIR_FILE_NAME=$(echo $tmp_dir | cut -d/ -f3)
  export BUILDKITE_BUILD_CHECKOUT_PATH=$tmp_dir
  export BUILDKITE_PLUGIN_MODIFY_CHECKOUT_PATH_PATTERN="/tmp?/tmp2"

  run "$environment_hook"

  assert_success
  assert [ $BUILDKITE_BUILD_CHECKOUT_PATH = "/tmp2/$TMP_DIR_FILE_NAME" ]
  assert_output --partial "Cshanged BUILDKITE_BUILD_CHECKOUT_PATH"
}