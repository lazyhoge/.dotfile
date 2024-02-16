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
    # remote access
    remmina

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

  # vscode
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      ms-vscode-remote.remote-ssh
      mhutchie.git-graph
      bierner.emojisense
      streetsidesoftware.code-spell-checker
    ];
    userSettings = {
      editor.minimap.enabled = false; # ミニマップを非表示にする
      editor.renderControlCharacters = true; #  制御文字を表示する
      editor.suggestSelection = "first"; #  サジェスト一覧の初期表示項目設定
      breadcrumbs.enabled = true; #  ファイルのパンくずリストを表示する
      files.insertFinalNewline = true; #  ファイルの末尾を改行で終わらせる
      editor.fontLigatures = true; #  合字を有効化
      editor.fontSize = 17; #  フォントサイズを変更
      editor.renderLineHighlight = "all"; #  選択行の行番号をハイライトする
      editor.cursorBlinking = "smooth"; #  カーソルが滑らかに点滅するように
      editor.cursorSmoothCaretAnimation = true; #  カーソルの点滅をアニメーション表示する
      editor.cursorStyle = "block"; #  カーソルの外観をブロックに変更
      files.autoGuessEncoding = true; #  ファイルの自動エンコードを実施
      window.zoomLevel = 0; #  画面全体の表示サイズはデフォルト
      editor.bracketPairColorization.enabled = true; # 括弧の対応を色付ける
    };
    keybindings = [
      {
        key = "ctrl+n";
        command = "-workbench.action.files.newUntitledFile";
      }
      {
      key = "cmd+n";
      command = "explorer.newFile";
      }
    ];
  };

  # zsh
  programs.zsh = {
    enable = true;
  };

  # rofi
  programs.rofi = {
    enable = true;
  };
}
