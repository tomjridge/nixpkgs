# based on https://nixos.org/wiki/Development_Environments clang.nix

# NIX_PATH=.. nix-shell ocamlenv.nix -A ocamlEnv

let
     pkgs = import <nixpkgs> {};
     stdenv = pkgs.stdenv;
   in rec {
     ocamlEnv = stdenv.mkDerivation rec {
       name = "ocaml-env";
       version = "1.1.1.1";
       src = ./.;
       buildInputs = [ pkgs.ocaml_4_02_1 pkgs.ocamlPackages_latest.findlib pkgs.ocamlPackages_latest.base64 pkgs.ocamlPackages_latest.p3];
     };
   }