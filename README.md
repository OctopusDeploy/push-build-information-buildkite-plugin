# Push Build Information Buildkite Plugin

This is a Buildkite plugin to push build information to [Octopus Deploy](https://octopus.com/). 

**This plugin requires [Octopus CLI](https://octopus.com/downloads/octopuscli) to be installed on the Buildkite agent.**

## Build information in Octopus Deploy

When deploying a release, it is useful to know which build produced the artifact, what commits it contained, and which work items it is associated with. The Build information feature allows you to upload information from your build server, manually or with the use of a plugin, to Octopus Deploy.

Build information is associated with a package and includes:

- Build URL: A link to the build which produced the package.
- Commits: Details of the source commits related to the build.
- Issues: Issue references parsed from the commit messages.

More information about build information in Octopus Deploy:

- [Build information](https://octopus.com/docs/packaging-applications/build-servers/build-information)
- [Push build information](https://octopus.com/docs/octopus-rest-api/octopus-cli/build-information)

## Examples

Incorporate the following step in your `pipeline.yml` to create a release in Octopus Deploy:

### Basic examples

```yml
steps:
  - label: ":octopus-deploy: Push build info to Octopus Deploy"
    plugins: 
      - OctopusDeploy/push-build-information#v0.0.1:
          api_key: "${MY_OCTOPUS_API_KEY}"
          packages: "HelloWorld"
          package_version: "1.0.0"
          server: "${MY_OCTOPUS_SERVER}"
```

**Overwriting existing build information for a package version**

```yml
steps:
  - label: ":octopus-deploy: Push build info to Octopus Deploy"
    plugins: 
      - OctopusDeploy/push-build-information#v0.0.1:
          api_key: "${MY_OCTOPUS_API_KEY}"
          packages: "HelloWorld"
          package_version: "1.0.0"
          overwrite_mode: "OverwriteExisting"
          server: "${MY_OCTOPUS_SERVER}"
```

## 📥 Inputs

**The following inputs are required:**
| Name                           | Description                                                                                                                                                                                                                                                                       |
| :----------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `packages`                     | A single package ID or a list of package IDs.                                                                                           |
| `package_version`              | The version of the package; defaults to a timestamp-based version.                                                                                                                                                                       |

**The following inputs are optional:**

| Name                           | Description                                                                                                                                                                                                                                                          |  Default   |
| :----------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--------: |
| `api_key`                      | The API key used to access Octopus Deploy. You must provide an API key or set the `OCTOPUS_CLI_API_KEY` environment variable. If the guest account is enabled, a key of API-GUEST may be used. It is strongly recommended that this value retrieved from an environment variable.
| `config_file`                  | The path to a configuration file of default values with one `key=value` per line.                                                                                                                                                                                    |            |
| `debug`                        | Enable debug logging.                                                                                                                                                                                                                                                |  `false`   |
| `ignore_ssl_errors`            | Ignore certificate errors when communicating with Octopus Deploy. Warning: enabling this option creates a security vulnerability.                                                                                                                                    |  `false`   |
| `log_level`                    | The log level; valid options are `verbose`, `debug`, `information`, `warning`, `error`, and `fatal`.                                                                                                                                                                 |  `debug`   |
| `overwrite_mode`               | Determines behavior if the package already exists in the repository. Valid values are `FailIfExists`, `OverwriteExisting` and `IgnoreIfExists`.                                                                                                                                                                                                        | `FailIfExists` |
| `proxy`                        | The URL of a proxy to use (i.e. `https://proxy.example.com`).                                                                                                                                                                                                        |            |
| `proxy_password`               | The password used to connect to a proxy. It is strongly recommended following the guidelines in the Buildkite [Managing Pipeline Secrets docs](https://buildkite.com/docs/pipelines/secrets). If `proxy_username` and `proxy_password` are omitted and `proxy` is specified, the default credentials are used.                                    |            |
| `proxy_username`               | The username used to connect to a proxy. It is strongly recommended following the guidelines in the Buildkite [Managing Pipeline Secrets docs](https://buildkite.com/docs/pipelines/secrets).                                                                                                                                                     |            |
| `server`                       | The base URL hosting Octopus Deploy (i.e. "https://octopus.example.com/"). It is recommended to retrieve this value from the `OCTOPUS_CLI_SERVER` environment variable.                                                                                                                                                    |            |
| `space`                        | The name or ID of a space within which this command will be executed. If omitted, the default space will be used.                                                                                                                                                    |            |
| `timeout`                      | A timeout value for network operations (in seconds).                                                                                                                                                                                                                 |   `600`    |

## Developing

To run the tests:

```shell
docker-compose run --rm tests
```

To lint the plugin:

```shell
docker-compose run --rm lint
```
