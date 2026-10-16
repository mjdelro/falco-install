# Falco install

An archived 2019 experiment for running Falco and Falco Event Generator in Docker on Ubuntu.

## What is included

- `docker-compose.yml` defines privileged Falco and event-generator containers.
- `sysdig-falco.sh` installs an older Docker CE setup, then launches both containers through GNU Screen.

## Important warning

Do not run `sysdig-falco.sh` on a current system without reviewing and updating it first. It targets Ubuntu 16.04 through 18.10, uses the retired `apt-key` workflow, downloads unpinned container images, and starts Falco with privileged host access.

The event-generator container deliberately produces activity for testing Falco rules. Use it only on an isolated test machine.

For a current installation, follow the [official Falco documentation](https://falco.org/docs/setup/).

## License

See [LICENSE](LICENSE).
