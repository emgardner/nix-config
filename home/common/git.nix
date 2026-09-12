{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "emgardner";
        email = "gardner.ethan10@gmail.com";
      };
      init.defaultBranch = "main";
      pull.ff = "only";
      credential.helper = "manager";
    };
  };
}
