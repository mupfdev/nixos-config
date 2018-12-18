# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./custom.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable      = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable                 = true;

  system.autoUpgrade.enable            = true;
  nix.useSandbox                       = true;
  hardware.cpu.intel.updateMicrocode   = true;
  hardware.bluetooth.enable            = true;
  hardware.bluetooth.powerOnBoot       = true;

  # Select internationalisation properties.
  i18n = {
    consoleKeyMap = "de";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   wget vim
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:
  services.clamav.daemon.enable        = true;
  services.clamav.updater.enable       = true;
  services.cron.enable                 = true;
  services.logrotate.enable            = true;
  services.rsyslogd.enable             = true;
  services.thinkfan.enable             = true;
  services.logind.lidSwitch            = "ignore";

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable                          = true;
    challengeResponseAuthentication = false;
    forwardX11                      = true;
    passwordAuthentication          = false;
    permitRootLogin                 = "without-password";
    ports                           = [ 58369 ];

    extraConfig = ''
      PubkeyAuthentication yes

      UseDNS no
      usePAM no

      ClientAliveInterval 300
      ClientAliveCountMax 3

      LoginGraceTime 30
      MaxStartups 5:10:20
    '';
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking = {
    defaultGateway = {
      address   = "10.0.0.1";
      interface = "wlp3s0";
    };

    hosts = {
      "10.0.0.1"  = [ "io" ];
      "10.0.0.2"  = [ "europa" ];
      "10.0.0.3"  = [ "ganymede" ];
      "10.0.0.4"  = [ "callisto" ];
      "10.0.0.5"  = [ "amalthea" ];
      "10.0.0.6"  = [ "himalia" ];
      "10.0.0.7"  = [ "elara" ];
      "10.0.0.8"  = [ "pasiphae" ];
      "10.0.0.9"  = [ "sinope" ];
      "10.0.0.10" = [ "lysithea" ];
      "10.0.0.11" = [ "carme" ];
      "10.0.0.12" = [ "ananke" ];
      "10.0.0.13" = [ "leda" ];
      "10.0.0.14" = [ "thebe" ];
      "10.0.0.15" = [ "adrastea" ];
      "10.0.0.16" = [ "metis" ];
      "10.0.0.17" = [ "callirrhoe" ];
      "10.0.0.18" = [ "themisto" ];
      "10.0.0.19" = [ "megaclite" ];
      "10.0.0.20" = [ "taygete" ];
      "10.0.0.21" = [ "chaldene" ];
      "10.0.0.22" = [ "harpalyke" ];
      "10.0.0.23" = [ "kalyke" ];
      "10.0.0.24" = [ "iocaste" ];
      "10.0.0.25" = [ "erinome" ];
      "10.0.0.26" = [ "isonoe" ];
      "10.0.0.27" = [ "praxidike" ];
      "10.0.0.28" = [ "autonoe" ];
      "10.0.0.29" = [ "thyone" ];
      "10.0.0.30" = [ "hermippe" ];
      "10.0.0.31" = [ "aitne" ];
      "10.0.0.32" = [ "eurydome" ];
      "10.0.0.33" = [ "euanthe" ];
      "10.0.0.34" = [ "euporie" ];
      "10.0.0.35" = [ "orthosie" ];
      "10.0.0.36" = [ "sponde" ];
      "10.0.0.37" = [ "kale" ];
      "10.0.0.38" = [ "pasithee" ];
      "10.0.0.39" = [ "hegemone" ];
      "10.0.0.40" = [ "mneme" ];
      "10.0.0.41" = [ "aoede" ];
      "10.0.0.42" = [ "thelxinoe" ];
      "10.0.0.43" = [ "arche" ];
      "10.0.0.44" = [ "kallichore" ];
      "10.0.0.45" = [ "helike" ];
      "10.0.0.46" = [ "carpo" ];
      "10.0.0.47" = [ "eukelade" ];
      "10.0.0.48" = [ "cyllene" ];
      "10.0.0.49" = [ "kore" ];
      "10.0.0.50" = [ "herse" ];
    };

    nameservers = [
      "85.214.20.141"
      "194.150.168.168"
      "10.0.0.1"
    ];
  };

  # Wireshark
  programs.wireshark.enable  = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable                = true;
  hardware.pulseaudio.enable  = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  # Enable the X11 windowing system.
  services.xserver.enable     = true;
  services.xserver.layout     = "de";
  services.xserver.xkbOptions = "eurosign:e";
  services.xserver.autorun    = true;

  # Enable touchpad support.
  services.xserver.libinput.enable             = true;
  services.xserver.libinput.disableWhileTyping = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  hardware.opengl.enable                               = true;
  hardware.opengl.driSupport32Bit                      = true;
  services.xserver.displayManager.auto.enable          = true;
  services.xserver.displayManager.auto.user            = "micha";
  services.xserver.desktopManager.plasma5.enable       = true;

  virtualisation.libvirtd.enable                       = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };
  users.defaultUserShell = pkgs.zsh;
  users.users.micha = {
    isNormalUser = true;
    group        = "users";
    home         = "/home/micha";
    createHome   = true;
    description  = "Michael Fitzmayer";
    extraGroups  = [ "input" "libvirtd" "networkmanager" "power" "vboxusers" "video" "wheel" "wireshark" ];
    uid          = 1000;
  };

  programs.zsh.enable             = true;
  programs.zsh.enableCompletion   = true;
  services.nixosManual.showManual = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
