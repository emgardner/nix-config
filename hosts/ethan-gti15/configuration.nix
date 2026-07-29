{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../common/default.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "ethan-gti15"; # Define your hostname.
  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.autoSuspend = false;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [];
  services.openssh.enable = true;
  system.stateVersion = "25.11"; # Did you read the comment?
}
