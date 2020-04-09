{ pkgs }:
with pkgs;
weechat.override {
  configure = { availablePlugins, ... }: {
    plugins = builtins.attrValues (availablePlugins // {
      python = availablePlugins.python.withPackages (ps: with ps; [ pycrypto ]);
    });
    scripts = with pkgs.weechatScripts; [
      #weechat-xmpp weechat-matrix-bridge
      #vimode
      wee-slack
    ];
    init = ''
      /set plugins.var.python.jabber.key "val"
      /python load python/autoload/wee_slack.py
    '';
  };
}
