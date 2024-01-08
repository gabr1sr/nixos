{ inputs, system, ... }:
final: prev: {
  vscode-solidity-server =
    final.callPackage ../packages/vscode-solidity-server.nix { };

  dangerzone = final.callPackage ../packages/dangerzone/default.nix { };

  # generated using nix4vscode
  vscode-extensions = final.lib.recursiveUpdate prev.vscode-extensions {
    "jebbs"."plantuml" = final.vscode-utils.extensionFromVscodeMarketplace {
      name = "plantuml";
      publisher = "jebbs";
      version = "2.17.5";
      sha256 = "0l0amipyf74bkyiksnqfy2qcvv3qsshk9bqqqx28fk06nvx1zy8b";
    };

    "juanblanco"."solidity" =
      final.vscode-utils.extensionFromVscodeMarketplace {
        name = "solidity";
        publisher = "juanblanco";
        version = "0.0.165";
        sha256 = "002gqf524c8q3ghbr5mwq6v3rn09b9p3nwz0pfqhcil9zzx7r5h4";
      };

    "tintinweb"."graphviz-interactive-preview" =
      final.vscode-utils.extensionFromVscodeMarketplace {
        name = "graphviz-interactive-preview";
        publisher = "tintinweb";
        version = "0.3.5";
        sha256 = "0fkrrljyszlc7j1il17xykmwcvsbwqxqqgc4v3cg45wmc5f923z4";
      };

    "tintinweb"."vscode-solidity-language" =
      final.vscode-utils.extensionFromVscodeMarketplace {
        name = "vscode-solidity-language";
        publisher = "tintinweb";
        version = "0.0.7";
        sha256 = "0fqpyxvpav3lyn91i7ajysfbcdnxa22r2vp6qziqfz4nnl7q92cv";
      };

    "tintinweb"."solidity-visual-auditor" =
      final.vscode-utils.extensionFromVscodeMarketplace {
        name = "solidity-visual-auditor";
        publisher = "tintinweb";
        version = "0.2.0";
        sha256 = "1v3jaxcdnlyip6qgpyy6pp58d72pzgm9ryk3n5lkcbm721ldn8v2";
      };
  };
}
