let
  oldSparkPkgs = import (
    builtins.fetchTarball {
      name = "spark-nixpkgs";
      url = https://github.com/nixos/nixpkgs/archive/b8ab4451b53e3f8282ff3cbd8dde763e8b5e1d28.tar.gz;
      # Hash obtained using `nix-prefetch-url --unpack <url>`
      sha256 = "0cw3ff9n0zfc1k11sp8cm12g6b7x90yl23llhp8b78017x8lq71p";
    }
  ) {};
  sparkOverlay = self: super: {
    inherit (oldSparkPkgs) spark;
  };
in
[
  sparkOverlay
  (import ./nixpkgs-src)
]
