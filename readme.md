<p align="center">
  <img src="assets/icon.svg" alt="Falco Install Icon" width="104" height="104" />
</p>

<h1 align="center">Falco Install</h1>

<p align="center">Archived 2019 experiment for running Sysdig Falco and Event Generator in Docker on Ubuntu.</p>

<p align="center">
  <img src="https://img.shields.io/badge/status-archived%20experiment-64748b?style=flat-square" alt="" />
  <img src="https://img.shields.io/badge/Docker-Compose-2496ED?style=flat-square&logo=docker&logoColor=white" alt="" />
  <img src="https://img.shields.io/github/license/mjdelro/falco-install?style=flat-square&color=64748b" alt="" />
</p>

---

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
