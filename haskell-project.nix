{ inputs, ... }: {
  perSystem = { config, pkgs, system, ... }:
    let
      hsFlake = inputs.flake-lang.lib.${system}.haskellFlake {
        src = ./.;
        name = "vdf-hs";
        index-state = "2024-06-09T00:00:00Z";
        compiler-nix-name = "ghc965";
        devShellTools = [ pkgs.haskellPackages.apply-refact ] ++ config.pre-commit.settings.enabledPackages;
        devShellHook = ''
          export LC_CTYPE=C.UTF8
          export LC_ALL=C.UTF8
          export LAND=C.UTF8

          ${config.pre-commit.installationScript}
        '';
      };
    in
    {
      devShells = rec {
        dev-vdf-hs = hsFlake.devShell;
        default = dev-vdf-hs;
      };

      packages = rec {
        vdf-hs-lib = hsFlake.packages."vdf-hs:lib:vdf-hs";
        vdf-hs = hsFlake.packages."vdf-hs:exe:vdf-hs".overrideAttrs { meta.mainProgram = "vdf-hs"; };
        default = vdf-hs;
      };

      inherit (hsFlake) checks;
    };
}
