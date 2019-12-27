#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

tmp_dir=$(mktemp -d -t skip-checkout.XXXXXXXXXX)

pre_exit_hook="$PWD/hooks/pre-exit"
TMP_DIR_FILE_NAME=$(echo $tmp_dir | cut -d/ -f3)

@test "Modify BUILDKITE_BUILD_CHECKOUT_PATH" {
  export BUILDKITE_BUILD_CHECKOUT_PATH=$tmp_dir
  export BUILDKITE_PLUGIN_MODIFY_CHECKOUT_PATH_PATTERN="/tmp?/tmp2"
  export BUILDKITE_PLUGIN_MODIFY_CHECKOUT_PATH_CLEANUP=true
  run "$pre_exit_hook"
  assert_success
  assert_output --partial "Cleaning up /tmp2/$TMP_DIR_FILE_NAME"
}
