# sonclave
Unix user, groups, & ssh authorized_keys managment, backed by Github teams.

## Configuration

You can find an example configuration at [https://github.com/bongozone/beatniks](https://github.com/bongozone/beatniks)

## Run

```sh
/bin/sonclave go | ssh root@openbsdmachinehere
```

You'll see something like:
```
Sonclave path is /Users/jon/Projects/sonclave/.sonclave
+ set -f
+ usermod -v -S wheel,operator,staff,users -L staff -c Jon Williams jon
```

## Roadmap

- [x] Proof of Concept
- [ ] Ssh keys
- [ ] Github sync
  - [ ] ssh keys
  - [ ] team group mappings
-  Extended Lifecycle
  - [ ] Lock Users
  - [ ] Delete Users
- Platform support for backends
 - [x] OpenBSD
 - [ ] Debian
- Configuration `.sonclave/config` or command-line
 - [ ] Platform
 - [ ] authorized_keys location / scheme

## Inspiration
- [stackbuilders/openssh-github-keys](https://github.com/stackbuilders/openssh-github-keys)
