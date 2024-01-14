{ inputs, system, ... }:
final: prev: {
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

    "starkware"."cairo1" = final.vscode-utils.extensionFromVscodeMarketplace {
      name = "cairo1";
      publisher = "starkware";
      version = "2.3.0";
      sha256 = "0h5w1jhy22nhk3bhf0cgf0csxxn58d0klzzi6mbm404mcdg1hwkm";
    };

    "bungcip"."better-toml" = final.vscode-utils.extensionFromVscodeMarketplace {
      name = "better-toml";
      publisher = "bungcip";
      version = "0.3.2";
      sha256 = "08lhzhrn6p0xwi0hcyp6lj9bvpfj87vr99klzsiy8ji7621dzql3";
    };

    "rust-lang"."rust-analyzer" = final.vscode-utils.extensionFromVscodeMarketplace {
      name = "rust-analyzer";
      publisher = "rust-lang";
      version = "0.4.1805";
      sha256 = "0b8x02lhlr5049m5vakizlgv1xjawppnrczni1rp8ga0ng3w4d4s";
    };

    "huff-language"."huff-language" = final.vscode-utils.extensionFromVscodeMarketplace {
      name = "huff-language";
      publisher = "huff-language";
      version = "0.0.32";
      sha256 = "1ykhzs3nllbnl0dpb2xlvd4m9hj8am7nzz1fx9zw2z2gylx533js";
    };
  };
}
