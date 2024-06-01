{
  description = "Elixir - Mix project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShell = pkgs.mkShell {
        nativeBuildInputs = [ pkgs.bashInteractive ];
        buildInputs = with pkgs; [
          beam.packages.erlang_26.elixir
          beam.packages.erlang_26.elixir-ls
          beam.packages.erlang_26.erlang
          beam.packages.erlang_26.erlang-ls
        ];
        shellHook = ''
          if [ ! -e ./mix.exs ]; then
             mix new ./
          fi
        '';
      };
    });
}
