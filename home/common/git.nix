{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "emgardner";
        email = "gardner.ethan10@gmail.com";
      };
      core {
        editor = "vim";
      };
      init.defaultBranch = "main";
      pull.ff = "only";
      credential.helper = "manager";
    };
  };
}
