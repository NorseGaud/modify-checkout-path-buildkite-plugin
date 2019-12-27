#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

tmp_dir=$(mktemp -d -t skip-checkout.XXXXXXXXXX)

function cleanup {
  rm -rf "$tmp_dir"
}
trap cleanup EXIT

environment_hook="$PWD/hooks/environment"
TMP_DIR_FILE_NAME=$(echo $tmp_dir | cut -d/ -f3)

@test "Modify BUILDKITE_BUILD_CHECKOUT_PATH" {
  export BUILDKITE_BUILD_CHECKOUT_PATH=$tmp_dir
  export BUILDKITE_PLUGIN_MODIFY_CHECKOUT_PATH_PATTERN="/tmp?/tmp2"
  run "$environment_hook"
  assert_success
  assert_output --partial "Changed BUILDKITE_BUILD_CHECKOUT_PATH to /tmp2/$TMP_DIR_FILE_NAME"
}

@test "Modify BUILDKITE_BUILD_CHECKOUT_PATH with interpolation" {
  export BUILDKITE_AGENT_NAME="server-123"
  export BUILDKITE_BUILD_ID="asdf-1234fd-fwreffd"
  export BUILDKITE_BUILD_CHECKOUT_PATH="/$BUILDKITE_AGENT_NAME/$TMP_DIR_FILE_NAME"
  export BUILDKITE_PLUGIN_MODIFY_CHECKOUT_PATH_PATTERN="\${BUILDKITE_AGENT_NAME}?$BUILDKITE_BUILD_ID"
  run "$environment_hook"
  assert_success
  assert_output --partial "Changed BUILDKITE_BUILD_CHECKOUT_PATH to /$BUILDKITE_BUILD_ID/$TMP_DIR_FILE_NAME"
}

