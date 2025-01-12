{ config, pkgs, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hibernate.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Copenhagen";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };
  console.keyMap = "dk-latin1";

  # Enable the GNOME Desktop Environment.
  services.xserver = {
    enable = true;
    layout = "dk";
    xkbVariant = "";
    displayManager.gdm.enable = true;
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverrides = ''
        [org.gnome.desktop.wm.preferences]
        button-layout=':minimize,maximize,close'

        [org.gnome.settings-daemon.plugins.color]
        night-light-enabled=true
      '';
    };
  };

  # Enable sound with pulseaudio.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

# Everyone hates electron.
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
  
  # Enable flakes support.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jonas = {
    isNormalUser = true;
    description = "Jonas";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      rustc
      cargo
      firefox
      httrack
      google-chrome
      bitwarden
      alacritty
      vscode
      arduino
      obsidian
      gimp
      qbittorrent
      vlc
      handbrake
      libreoffice
      telegram-desktop
      prusa-slicer
      blender
      thunderbird
      baobab # Disk usage analyser and visualization tool. Like windirstat.
      ventoy
      mullvad-vpn
      audacity
      obs-studio
      soundkonverter
      tor-browser
      kleopatra # Certificate (& PGP key) manager GUI.
      wine
      slack
      imagemagick
      kdenlive
      inkscape
      tailscale
      android-studio
      gopls
    ];
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
      neovim
      wget
      git
      tmux
      fish
      p7zip
      kanata
      gnumake
      gcc13 # GNU compiler collection
      xclip # Clipboard tool
      ripgrep
      fzf
      gnupg # Generates keys (PGP)
      ffmpeg
      rename # Bulk rename util
      libGL # Required for android studio
      qemu # Required for android studio
      android-tools # Required for android studio
      docker
      which
      go
  ];

  # Setting some GNOME envvars to help GNOME locate some resources. Namely icons for apps.
  environment.sessionVariables = {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
    # XDG_DATA_DIRS   = "/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
  };

  # Services
  services.thermald.enable = true; # Service helps with power management and battery life (?)
  services.kanata = { # Keyboard remapping using Kanata (caps -> esc)
    enable = true;
    keyboards.default = {
      config = ''
        (defsrc caps)
        (deflayer jonas @xcaps)
        (defalias xcaps esc)
      '';
    };
  };
  services.mullvad-vpn.enable = true;
  services.tailscale.enable = true;
  services.colord.enable = true; # Enable color service, for night light.
  services.printing.enable = true; # Enable CUPS to print documents.
  services.flatpak.enable = true;

  # Options for programs.
  programs.fish.enable = true;
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  # Docker
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = ["jonas"];
}
