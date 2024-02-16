# lazyhoge's home configuration

{ pkgs, ...}:{

  home = rec { # recでAttribute Set内で他の値を参照できるようにする
    username="lazyhoge";
    homeDirectory = "/home/${username}"; # 文字列に値を埋め込む
    stateVersion = "23.11";

    # 壁紙
#    file = {
#      "wallpaper.png" = {
#      target = "Wallpaper/wallpaper.png"; # ~/Wallpaper/wallpaper.pngに配置
#      source = ./wallpaper/nix_4k.jpg; # 配置するファイル
#      };
#    };
  };

  # ユーザー環境にインストールするパッケージくん
  home.packages = with pkgs; [
    # cli tools
    neofetch
    nnn # ファイルマネージャー
    starship # ターミナルプロンプト

    # cli commands
    zip
    ripgrep # grepの強いやつ
    jq # jsonいじるやつ
    yq-go # jqのyaml版
    eza # ls 互換
    delta # 見やすいdiff
    fd # find 代替
    gh # github cli tool
    xh # http client
    fzf # いい感じに検索
    lynx # terminal web browzer

    # cli network tools
    mtr # pingとtracerouteでnetworkcheck
    iperf3 # speed test
    dnsutils # dig + nslookup
    ldns # dig
    aria2 # multi-protocol downloader curl,wget代替
    socat # いろんな通信転送くん
    nmap # port scanning
    ipcalc # subnet計算くん

    file # ファイルの種類
    which
    tree
    gnupg # 暗号化ツール

    # nix related
    nix-output-monitor

    # systemcall monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    ethtool
    pciutils # lspci
    usbutils # lsusb

    # desktop tools
    rofi

    # As developer
    # code
    vscode
    # network
    wireshark

    # As user
    # web
    google-chrome
    firefox
    vivaldi
    # video
    vlc
    # image
    # office
    wpsoffice
    # game
    parsec-bin
    # communication
    discord
    slack
    teams-for-linux

    # As creator
    # image
    gimp-with-plugins
    inkscape-with-extensions
  ];

  # home-managerで管理する設定
  # home-manager
  programs.home-manager.enable = true; # home-manager自身でhome-managerを有効化

  # git
  programs.git = {
    enable = true;
    userName = "lazyhoge";
    userEmail = "contact@lazyhoge.foo";
    extraConfig.pull.rebase = false;
  };

  #starship
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  programs.zsh = {
    enable = true;
  };

  # rofi
  programs.rofi = {
    enable = true;
  };
}
