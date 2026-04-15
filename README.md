# Local build
1. Install [nix](https://nixos.org/download), [direnv](https://direnv.net/docs/installation.html), and [nix-direnv](https://github.com/nix-community/nix-direnv).
2. Setup [shell hook](https://direnv.net/docs/hook.html) for direnv.
3. Enter the shell environment:
```sh
   direnv allow
   just init
```
4. Build:
```sh
   just build all
```
