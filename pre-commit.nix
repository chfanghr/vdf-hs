{ inputs, ... }: {
  imports = [ inputs.pre-commit-hooks.flakeModule ];
  perSystem = {
    pre-commit = {
      check.enable = true;

      settings.hooks = {
        # Nix
        nixpkgs-fmt.enable = true;
        deadnix.enable = true;
        statix.enable = true;

        # Haskell
        fourmolu.enable = true;
        ormolu.settings.cabalDefaultExtensions = true;
        hlint.enable = true;

        # Misc
        typos = {
          enable = true;
          settings = {
            configuration = ''
              [default.extend-words]
              substituters = "substituters"
              hask = "hask"
              lits = "lits"
              Nd = "Nd"
              anc = "anc"
              eit = "eit"
            '';
            exclude = "fourmolu.yaml";
          };
        };
      };
    };
  };
}
