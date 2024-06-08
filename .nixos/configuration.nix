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

  # Define your hostname.
  networking.hostName = "nixos";

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
      rclone
      rustc
      cargo

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
      telegram-desktop
      prusa-slicer
      openscad
      blender
      thunderbird
      wine
      baobab # Disk usage analyser and visualization tool. Like windirstat.
      ventoy
      mullvad-vpn
      gnome-network-displays
      audacity
      steam
      obs-studio
      soundkonverter
      tor-browser
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
      pinentry-curses # Needed for GPG to work.
  ];

  environment.sessionVariables = {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
  };

  # Services
  services.thermald.enable = true; # Service to help prevent CPU overheating(?)
  services.kanata = {
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

  # Options for programs.
  programs.fish.enable = true;
  programs.steam.enable = true;
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  # Needed for GPG to work: https://discourse.nixos.org/t/cant-get-gnupg-to-work-no-pinentry/15373/22
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSSHSupport = true;
  };
}
