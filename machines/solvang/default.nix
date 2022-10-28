{ config, lib, pkgs, ... }:

{
  imports = [
    ../modules
  ];

  networking = {
    hostName = "discovery";
    computerName = "discovery";
  };

  system = {
    stateVersion = 4;
  };
}