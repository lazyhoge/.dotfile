# nixos configure of LHnixos01

{inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./vm.nix
      ./PCIe_paththrough.nix
    ];

  # Hardware modules
#  ++ (with inputs.nixos-hardware.nixosModules; [
#    common-cpu-amd
#    common-gpu-nvidia
#    common-pc-ssd
#  ]);

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # Network
  networking.hostName = "LHnixos01";

  networking = {
    interfaces = {
      enp5s0 = {
        useDHCP = true;
      };
    };
    bridges = {
      br0 = {
        interfaces = ["enp5s0"];
      };
    };
  };

  # Time zone
  time.timeZone = "Asia/Tokyo";

  # Internationalisation properties.
  i18n.defaultLocale = "ja_JP.UTF-8";

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = [pkgs.fcitx5-mozc];
  };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };

  # Display server
  services.xserver.enable = true;

  # Desktop Environment (KDE plasma)
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "jp";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "jp106";

  # Configure fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerdfonts
    ];
    fontDir.enable = true;
    fontconfig = {
      defaultFonts = {
        serif = ["Noto Serif CJK JP" "Noto Color Emoji"];
        sansSerif = ["Noto Sans CJK JP" "Noto Color Emoji"];
        monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # User
  users.users.lazyhoge = {
    isNormalUser = true;
    description = "lazyhoge";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  # packages for system (root)
  environment.systemPackages = with pkgs; [
    git
    curl
    zsh
    libvirt
    btrfs-progs
    btrfs-snap
    firefox
  ];

  # List services that you want to enable:
  #git
  programs.git.enable = true;
  #zsh
  programs.zsh.enable = true;
  # OpenSSH
  services.openssh.enable = true;
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [22];
  networking.firewall.allowedUDPPorts = [22];


  # nix
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };
  
  nixpkgs.config.allowUnfree = true; #プロプライエタリOK

  # virtualization
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    libvirtd = {
      enable = true;
      
    };
  };

  # Config to install apps non suported by NixOS
  services.flatpak.enable = true;
  xdg.portal.enable = true; #flatpak needs this



  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
