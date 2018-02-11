# sonclave
Dead-simple Unix user, groups, & ssh authorized_keys management, backed by Github teams.

## Configuration

You can find an example configuration at [https://github.com/bongozone/beatniks](https://github.com/bongozone/beatniks).
Put this in `.sonclave` for now. Generate a token:
```sh
bin/sonclave-token
```
and put it in your `~/.netrc` (NB: might not work with 2FA disabled on Github)
```
machine api.github.com
  login WIZARDISHUNGRY
  password deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
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

## TODO

- [ ] Better name
- [ ] Delete users
- [ ] Lock users
- [ ] Configuration options `.sonclave/config` or command-line
- [ ] `authorized_keys` location / scheme
- [ ] YAML schema validation
- [ ] String keys inside `unix` configuration array have arbitrary presidence

## Prior art
- [stackbuilders/openssh-github-keys](https://github.com/stackbuilders/openssh-github-keys)
