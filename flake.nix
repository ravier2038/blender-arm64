{
  description = "Blender for linux arm64";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];

      packagesFor = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          # On an x86_64 host, cross compile; on an arm64 host, build natively.
          target =
            if system == "aarch64-linux"
            then pkgs
            else pkgs.pkgsCross.aarch64-multiplatform;
        in {
          default = target.blender;
        };
    in {
      packages = nixpkgs.lib.genAttrs systems packagesFor;
    };
}
