# root

The root repository of the fictorg example, for [orca](https://github.com/adamkirk/orca): the workspace config, and traefik, which routes `*.orca-fictorg.test` to the other projects over TLS.

```sh
mkdir -p ~/code/fictorg && cd ~/code/fictorg
orca ws init --repo orca-fictorg/root
```

That clones every project, sets each one up with its `clone.post` hook, and seeds the sample data with the workspace's `init.post`. Then:

```sh
orca ws switch orca-fictorg
orca tls gen
orca up
```

| Project | What it shows |
| ------- | ------------- |
| `root` | This repository, registered with `self: true`. The network overlay is created here, and traefik gets orca's certificates with the TLS injection overlay. |
| `svc-a` | A Go service, with a `syncFile` `.env`, a command in its container (`orca ext os-info`), and a smoke test after it starts (`up.post`). |
| `sdk` | A library, cloned inside `svc-a` at `vendor/sdk`, built by its `clone.post` hook. |
| `svc-b` | A node service, cloned on its `orca-adoption` branch, which links `sdk` into `node_modules` with a `symlink` extension. |
| `admin` | Disabled by default: cloned and set up, but not started. |

The workspace's own extensions, `check-tools`, `install-deps` and `seed`, are shared: `install-deps` runs `make deps` in each project that uses it.

Without adding the hosts to `/etc/hosts`, reach a service with `curl -k --resolve svc-a.orca-fictorg.test:28443:127.0.0.1 https://svc-a.orca-fictorg.test:28443`.
