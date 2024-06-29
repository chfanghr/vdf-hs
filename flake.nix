{
  inputs = {
    lambda-buffers.url = "github:mlabs-haskell/lambda-buffers";

    flake-lang.follows = "lambda-buffers/flake-lang";

    nixpkgs.follows = "lambda-buffers/nixpkgs";

    pre-commit-hooks.follows = "lambda-buffers/pre-commit-hooks";

    flake-parts.follows = "lambda-buffers/flake-parts";
  };


  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ./pre-commit.nix ./haskell-project.nix ];
      debug = true;
      systems = [ "x86_64-linux" ];
    };
}
