# sonclave
Dead-simple Unix user, groups, & ssh authorized_keys managment, backed by Github teams.

**Come up with a better name, please!**

## Configuration

You can find an example configuration at [https://github.com/bongozone/beatniks](https://github.com/bongozone/beatniks).
Put this in `.sonclave` for now. Generate a token:
```sh
bin/sonclave-token
```

## Run

```sh
bin/sonclave go | ssh root@openbsdmachinehere
```

You'll see something like:
```
Sonclave path is /Users/jon/Projects/sonclave/.sonclave
+ set -f
+ usermod -v -S wheel,operator,staff,users -c Jon\ Williams -L staff jon || useradd -v -m -G wheel,operator,staff,users -c Jon\ Williams -L staff jon
```

## Roadmap

- [x] Proof of Concept
- [ ] Ssh keys
- [x] Github sync
  - [x] ssh keys
  - [x] OAuth token generator
  - [x] Team -> group mappings
-  Extended Lifecycle
  - [ ] Lock Users
  - [ ] Delete Users
- Platform support for backends
 - [x] OpenBSD
 - [ ] Debian
- Configuration options `.sonclave/config` or command-line
 - [ ] Platform
 - [ ] authorized_keys location / scheme
- [ ] Bugs / "Enhancements"
  - [ ] YAML Schema validation
  - [ ] Data constraint error handling
  - [ ] String keys inside `unix` configuration array have arbitrary presidence

## Inspiration
- [stackbuilders/openssh-github-keys](https://github.com/stackbuilders/openssh-github-keys)
