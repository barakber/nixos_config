{ config, pkgs, ... }:
let
  networking = {
    hostName = "berkos";

#    wireless = {
#      enable = true;
#    };

    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [ 53 12345 22 139 445 3389 ];
      allowedUDPPorts = [ 53 137 138 ];
    };

#    extraHosts = (import ./private.nix { inherit config pkgs; }).extraHosts;

    resolvconf.dnsExtensionMechanism = false;
  };
in
  networking
