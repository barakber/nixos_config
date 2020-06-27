{ config, pkgs, ... }:
let
  samba = {
    enable = true;
    securityType = "user";
    enableWinbindd = false;
    enableNmbd = false;
    extraConfig = ''
      workgroup = WORKGROUP
      server string = smbnix
      netbios name = smbnix
      security = user
      #use sendfile = yes
      #max protocol = smb2
      hosts allow = 10.0.0.  localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      #map to guest = bad user
    '';
    shares = {
      public = {
        path = "/home/barak/Public";
        browseable = "yes";
        "read only" = false;
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "username";
        "force group" = "groupname";
      };
    };
  };
in
  samba
