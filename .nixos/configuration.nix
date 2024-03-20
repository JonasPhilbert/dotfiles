{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
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

  # Enable the GNOME Desktop Environment.
  services.xserver = {
    enable = true;
    layout = "dk";
    xkbVariant = "";
    xkbOptions = "caps:sweapescape";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Configure console keymap
  console.keyMap = "dk-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
  
  # Enable flakes support.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jonas = {
    isNormalUser = true;
    description = "Jonas";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      brave
      bitwarden
      alacritty
      vscode
      inkscape-with-extensions
      gimp
      qbittorrent
      vlc
      handbrake
      libreoffice
      obsidian
      telegram-desktop
      redshift
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
      git
      wget
      xclip # Clipboard tool
      fish
      neovim
      tmux
      ripgrep
      fzf
      rclone
      gcc13 # GNU compiler collection
      powertop
      geoclue2 # Location provider. Used by redshift
  ];

  # Allow certain packages, even though they have known security issues #yolo
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0" # Required by package/obsidian
  ];

  # Services
  services.thermald.enable = true; # Service to help prevent CPU overheating(?)
  services.tlp.enable = true; # Power management service.
  services.power-profiles-daemon.enable = false; # Disable GNOME power management, as it conflicts with tlp.
  services.geoclue2 = {
    enable = true;
    enableWifi = true;
  };

  # Options for programs.
  programs.fish.enable = true;
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
}
