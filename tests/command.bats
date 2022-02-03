#!/usr/bin/env bats

load "$BATS_PATH/load.bash"

# Uncomment to enable stub debug output:
# export DOCKER_STUB_DEBUG=/dev/tty

@test "Running push build information command" {
    export BUILDKITE_BRANCH="main"
    export BUILDKITE_BUILD_NUMBER="1541"
    export BUILDKITE_BUILD_URL="https://buildkite.com/acme-inc/my-project/builds/1514"
    export BUILDKITE_REPO="git@github.com:acme-inc/my-project.git"
    export BUILDKITE_COMMIT="83a20ec058e2fb00e7fa4558c4c6e81e2dcf253d"

    export OCTOPUS_CLI_SERVER="https://octopus.example"
    export OCTOPUS_CLI_API_KEY="API-xxxxxx"
    export BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGES="MyApp.Web"
    export BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGE_VERSION="1.0.0"

    stub docker "--env OCTOPUS_CLI_SERVER --env OCTOPUS_CLI_API_KEY run OctopusDeploy/octo:latest sh -e -c build-information --file /tmp/octopus.buildinfo --package-version 1.0.0 --package-id \'MyApp.Web\' : echo ran command in docker"

    run $PWD/hooks/command

    assert_output --partial "ran command in docker"
    assert_success

    unstub docker
    unset BUILDKITE_BRANCH
    unset BUILDKITE_BUILD_NUMBER
    unset BUILDKITE_BUILD_URL
    unset BUILDKITE_REPO
    unset BUILDKITE_COMMIT
    unset OCTOPUS_CLI_SERVER
    unset OCTOPUS_CLI_API_KEY
    unset BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGES
    unset BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGE_VERSION
}

@test "Running push build information command with multiple packages" {
    export BUILDKITE_BRANCH="main"
    export BUILDKITE_BUILD_NUMBER="1541"
    export BUILDKITE_BUILD_URL="https://buildkite.com/acme-inc/my-project/builds/1514"
    export BUILDKITE_REPO="git@github.com:acme-inc/my-project.git"
    export BUILDKITE_COMMIT="83a20ec058e2fb00e7fa4558c4c6e81e2dcf253d"

    export OCTOPUS_CLI_SERVER="https://octopus.example"
    export OCTOPUS_CLI_API_KEY="API-xxxxxx"
    export BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGES_0="MyApp.Web"
    export BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGES_1="MyApp.Data"
    export BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGE_VERSION="1.0.0"

    stub docker "--env OCTOPUS_CLI_SERVER --env OCTOPUS_CLI_API_KEY run OctopusDeploy/octo:latest sh -e -c build-information --file /tmp/octopus.buildinfo --package-version 1.0.0 --package-id \'MyApp.Web\' --package-id \'MyApp.Data\' : echo ran command in docker"

    run $PWD/hooks/command

    assert_output --partial "ran command in docker"
    assert_success

    unstub docker
    unset BUILDKITE_BRANCH
    unset BUILDKITE_BUILD_NUMBER
    unset BUILDKITE_BUILD_URL
    unset BUILDKITE_REPO
    unset BUILDKITE_COMMIT
    unset OCTOPUS_CLI_SERVER
    unset OCTOPUS_CLI_API_KEY
    unset BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGES_0
    unset BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGES_1
    unset BUILDKITE_PLUGIN_PUSH_BUILD_INFORMATION_PACKAGE_VERSION
}