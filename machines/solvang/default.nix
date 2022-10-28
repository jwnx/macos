{ config, lib, pkgs, ... }:

{
  imports = [
    ../modules
  ];

  networking = {
    hostName = "solvang";
    computerName = "solvang";
  };

  system = {
    stateVersion = 4;
  };
}