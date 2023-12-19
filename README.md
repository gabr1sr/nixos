# NixOS
My NixOS Configuration using Flakes + Home-Manager.

## Usage
To apply system changes/configurations use:
```sh
sudo nixos-rebuild switch --flake '.#desktop'
```

To apply home-manager changes/configurations use:
```sh
home-manager switch --flake '.#gabr1sr@desktop'
```

Or run the `build.sh` file to execute both commands.
