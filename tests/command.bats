#!/usr/bin/env bats

setup() {
    load "$BATS_PATH/load.bash"

    # Uncomment to enable stub debug output:
    # export OCTO_STUB_DEBUG=/dev/tty
}

@test "Running push build information command" {
    export BUILDKITE_BRANCH="main"
    export BUILDKITE_BUILD_NUMBER="1541"
    export BUILDKITE_BUILD_URL="https://buildkite.com/acme-inc/my-project/builds/1514"
    export BUILDKITE_REPO="git@github.com:acme-inc/my-project.git"
    export BUILDKITE_COMMIT="83a20ec058e2fb00e7fa4558c4c6e81e2dcf253d"
    export BUILDKITE_BUILD_CHECKOUT_PATH="/tmp"

    export BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGES="MyApp.Web"
    export BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGE_VERSION="1.0.0"

    stub octo "build-information --file /tmp/octopus.buildinfo --version 1.0.0 --package-id MyApp.Web : echo octo command ran"

    run $PWD/hooks/command

    assert_output --partial "octo command ran"
    assert_success

    unstub octo

    unset BUILDKITE_BRANCH
    unset BUILDKITE_BUILD_NUMBER
    unset BUILDKITE_BUILD_URL
    unset BUILDKITE_REPO
    unset BUILDKITE_COMMIT

    unset BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGES
    unset BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGE_VERSION
}

@test "Running push build information command with multiple packages" {
    export BUILDKITE_BRANCH="main"
    export BUILDKITE_BUILD_NUMBER="1541"
    export BUILDKITE_BUILD_URL="https://buildkite.com/acme-inc/my-project/builds/1514"
    export BUILDKITE_REPO="git@github.com:acme-inc/my-project.git"
    export BUILDKITE_COMMIT="83a20ec058e2fb00e7fa4558c4c6e81e2dcf253d"
    export BUILDKITE_BUILD_CHECKOUT_PATH="/tmp"

    export BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGES_0="MyApp.Web"
    export BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGES_1="MyApp.Data"
    export BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGE_VERSION="1.0.0"

    stub octo "build-information --file /tmp/octopus.buildinfo --version 1.0.0 --package-id MyApp.Web --package-id MyApp.Data : echo octo command ran"

    run $PWD/hooks/command

    assert_output --partial "octo command ran"
    assert_success

    unstub octo

    unset BUILDKITE_BRANCH
    unset BUILDKITE_BUILD_NUMBER
    unset BUILDKITE_BUILD_URL
    unset BUILDKITE_REPO
    unset BUILDKITE_COMMIT

    unset BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGES_0
    unset BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGES_1
    unset BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGE_VERSION
}

@test "Running push build information command overriding Server URL and API Key" {
    export FAKE_API_KEY="API-123"
    export BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_API_KEY="FAKE_API_KEY"
    export BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_SERVER="https://octopus.example"
    export BUILDKITE_BRANCH="main"
    export BUILDKITE_BUILD_NUMBER="1541"
    export BUILDKITE_BUILD_URL="https://buildkite.com/acme-inc/my-project/builds/1514"
    export BUILDKITE_REPO="git@github.com:acme-inc/my-project.git"
    export BUILDKITE_COMMIT="83a20ec058e2fb00e7fa4558c4c6e81e2dcf253d"
    export BUILDKITE_BUILD_CHECKOUT_PATH="/tmp"

    export BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGES="MyApp.Web"
    export BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGE_VERSION="1.0.0"

    stub octo "build-information --file /tmp/octopus.buildinfo --version 1.0.0 --package-id MyApp.Web --server https://octopus.example --apiKey API-123 : echo octo command ran"

    run $PWD/hooks/command

    assert_output --partial "octo command ran"
    assert_success

    unstub octo

    unset FAKE_API_KEY
    unset BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_API_KEY
    unset BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_SERVER

    unset BUILDKITE_BRANCH
    unset BUILDKITE_BUILD_NUMBER
    unset BUILDKITE_BUILD_URL
    unset BUILDKITE_REPO
    unset BUILDKITE_COMMIT

    unset BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGES
    unset BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGE_VERSION
}
