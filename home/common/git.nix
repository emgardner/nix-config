{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "emgardner";
        email = "gardner.ethan10@gmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = false;
      credential.helper = "manager";
    };
  };
}
