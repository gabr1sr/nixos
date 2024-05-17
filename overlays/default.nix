{ inputs, system, ... }:
final: prev: {
  feather-icon-font = final.callPackage ../packages/feather-icon-font { };
}
