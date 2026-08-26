{
  programs.ssh = {
    enable = true;
    # enableDefaultConfig = false;
    extraConfig = ''
      Host ethan-ser9
          HostName ethan-ser9
          User ethan
          Port 22
          IdentityFile ~/.ssh/id_ed25519

      Host ethan-gti15
          HostName ethan-gti15
          User ethang
          Port 22
          IdentityFile ~/.ssh/id_ed25519

      Host ethan-nixos
          HostName nixos
          User ethang
          Port 22
          IdentityFile ~/.ssh/id_ed25519
    '';
  };
}
