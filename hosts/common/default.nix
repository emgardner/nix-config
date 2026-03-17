{
  config,
  pkgs,
  ...
}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];
  networking.nameservers = ["1.1.1.1" "8.8.8.8" "8.8.8.4"];
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

  users.users.ethang = {
    isNormalUser = true;
    description = "Ethan Gardner";
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    tailscale
    kitty
    docker-compose
  ];

  services.tailscale = {
    enable = true;
    extraSetFlags = ["--ssh"];
  };

  programs.nix-ld.enable = true;
  programs.direnv.enable = true;
  programs.zsh.enable = true;
  virtualisation.docker = {
    enable = true;
  };
}
