{
    config,
    lib,
    pkgs,
    ...
}:

{
    imports = [
        ./hardware/laptop.nix
        ../apple-silicon-support
    ];
}
