{ pkgs, lib, config, options, ... }:

let
  cfg = config.my.modules.macos;

in

{
  options = with lib; {
    my = {
      modules = {
        macos = {
          enable = mkEnableOption ''
            Whether to enable macos module
          '';
        };
      };
    };
  };

  config = with lib;
    mkIf cfg.enable {
      homebrew = {
        brews = [
          "gcc"
          "mas"
        ];

        masApps = {
          # Name = App Id from the url
          "Amphetamine" = 937984704;
          "Debit & Credit" = 882637653;
          "DaisyDisk" = 411643860;
          # "1Password 7" = 1333542190;
          # "Bitwarden" = 1352778147;
          "The Unarchiver" = 425424353;
          # "Gestimer" = 990588172;
          # "Lightroom" = 1451544217;
          # "Twitter" = 1482454543;
          # "DaVinci Resolve" = 571213070;
          # "Tailscale" = 1475387142;
          # "Kindle" = 405399194;
        };
      };

      environment = {
        systemPackages = with pkgs; [
          m-cli
        ];
      };

      system = {
        defaults = {
          LaunchServices = {
            LSQuarantine = false;
          };

          NSGlobalDomain = {
            AppleMeasurementUnits = "Centimeters";
            AppleMetricUnits = 1;
            # ApplePressAndHoldEnabled = true;
            AppleShowAllExtensions = false;
            AppleShowScrollBars = "Always";
            AppleTemperatureUnit = "Celsius";
            NSAutomaticCapitalizationEnabled = false;
            NSAutomaticDashSubstitutionEnabled = false;
            NSAutomaticPeriodSubstitutionEnabled = false;
            NSAutomaticQuoteSubstitutionEnabled = false;
            NSAutomaticSpellingCorrectionEnabled = false;
            NSDisableAutomaticTermination = false;
            NSDocumentSaveNewDocumentsToCloud = true;
            NSNavPanelExpandedStateForSaveMode = true;
            NSNavPanelExpandedStateForSaveMode2 = true;
            NSScrollAnimationEnabled = true;
            NSTableViewDefaultSizeMode = 2;
            NSTextShowsControlCharacters = true;
            NSUseAnimatedFocusRing = false;
            PMPrintingExpandedStateForPrint = true;
            PMPrintingExpandedStateForPrint2 = true;
            "com.apple.mouse.tapBehavior" = null;
            "com.apple.swipescrolldirection" = true;
          };

          SoftwareUpdate = {
            AutomaticallyInstallMacOSUpdates = true;
          };

          dock = {
            autohide = true;
            autohide-delay = 0.5;
            expose-animation-duration = 0.1;
            mineffect = "genie";
            show-recents = false;
            tilesize = 64;

            wvous-tl-corner = 2;
            wvous-bl-corner = 3;
            wvous-tr-corner = 2;
            wvous-br-corner = 3;
          };

          finder = {
            AppleShowAllExtensions = false;
            FXEnableExtensionChangeWarning = false;
            QuitMenuItem = true;
            _FXShowPosixPathInTitle = true;
          };

          loginwindow = {
            DisableConsoleAccess = true;
            GuestEnabled = false;
            PowerOffDisabledWhileLoggedIn = true;
            RestartDisabledWhileLoggedIn = true;
            ShutDownDisabledWhileLoggedIn = true;
            SHOWFULLNAME = true;
          };

          screencapture = {
            location = "/Users/${config.my.username}/Pictures/Screenshots";
          };
        };
      };
    };
}