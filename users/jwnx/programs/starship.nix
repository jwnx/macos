{ pkgs, ... }:

{
  enable = true;

  settings = {
    add_newline = true;
    battery = {
      disabled = true;
    };

    directory = {
      truncation_length = 5;
      truncate_to_repo = false;
      truncation_symbol = "…/";
    };

    aws = {
        format = "on [$symbol($profile )(\($region\) )]($style)";
        disabled = false;
    };

    gcloud = {
        disabled = true;
    };

    nodejs = {
        disabled = true;
    };
  };
}