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

    services.dnsproxy = {
        enable = true;
        settings = {
            listen-addrs = [ "127.0.0.1" ];
            listen-ports = [ 53 ];

            upstream = ["https://cloudflare-dns.com/dns-query"];
        };
    };

    systemd.services.dnsproxy.serviceConfig = {
        AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ]; 
        CapabilityBoundingSet = [ "CAP_NET_BIND_SERVICE" ];
    };

    environment.etc."systemd/resolved.conf.d/dnsproxy.conf".text = ''
        [Resolve]
        DNS=127.0.0.1:5353  # Use the local dnsproxy service for DNS requests.
    '';

    services.resolved.enable = true;
    networking.nameservers = [ "127.0.0.1" ];
    networking.networkmanager.dns = "systemd-resolved";

    nix.settings = {
        substituters = [
            "https://nixos-apple-silicon.cachix.org"
        ];
        trusted-substituters = [
            "https://nixos-apple-silicon.cachix.org"
        ];
        trusted-public-keys = [
            "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
        ];
    };
}
