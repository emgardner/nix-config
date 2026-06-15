{
  programs.git = {
    enable = true;
    settings.user = {
      name = "emgardner";
      email = "gardner.ethan10@gmail.com";
    };
    extraConfig = {
      credential.helper = "manager";
    };
  };

  programs.ssh.enable = true;
}
