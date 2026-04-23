{
    config,
    lib,
    pkgs,
    ...
}:

{
    imports = [
        "../apple-silicon-support"
        "./hardware/laptop.nix"
    ];
}
