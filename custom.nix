{ config, pkgs, ... }:

{
  networking = {
    hostName = "";

    interfaces.wlp3s0.ip4 = [
      { address = ""; prefixLength = 24; }
    ];

    wireless = {
      enable = true;
      networks = {
        io = {
          psk = "";
        };
      };
    };
  };
}
