{ config, lib, pkgs, ... }:

with pkgs;
with lib;

let

  cfg = config.services.opensmtpd;
  conf = writeText "smtpd.conf" cfg.serverConfiguration;
  args = concatStringsSep " " cfg.extraServerArgs;

in {

  ###### interface

  options = {

    services.opensmtpd = {

      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to enable the OpenSMTPD server.";
      };

      extraServerArgs = mkOption {
        type = types.listOf types.str;
        default = [];
        example = [ "-v" "-P mta" ];
        description = ''
          Extra command line arguments provided when the smtpd process
          is started.
        '';
      };

      serverConfiguration = mkOption {
        type = types.string;
        default = "";
        example = ''
          listen on lo
          accept for any deliver to lmtp localhost:24
        ''; 
        description = ''
          The contents of the smtpd.conf configuration file. See the
          OpenSMTPD documentation for syntax information. If this option
          is left empty, the OpenSMTPD server will not start.
        '';
      };

      procPackages = mkOption {
        type = types.listOf types.path;
        default = [];
        description = ''
          Packages to search for filters, tables, queues, and schedulers.

          Add OpenSMTPD-extras here if you want to use the filters, etc. from
          that package.
        '';
      };
    };

  };


  ###### implementation

  config = mkIf config.services.opensmtpd.enable {
    users.extraGroups = {
      smtpd.gid = config.ids.gids.smtpd;
      smtpq.gid = config.ids.gids.smtpq;
    };

    users.extraUsers = {
      smtpd = {
        description = "OpenSMTPD process user";
        uid = config.ids.uids.smtpd;
        group = "smtpd";
      };
      smtpq = {
        description = "OpenSMTPD queue user";
        uid = config.ids.uids.smtpq;
        group = "smtpq";
      };
    };

    systemd.services.opensmtpd = let
      procEnv = pkgs.buildEnv {
        name = "opensmtpd-procs";
        paths = [ opensmtpd ] ++ cfg.procPackages;
        pathsToLink = [ "/libexec/opensmtpd" ];
      };
    in {
      wantedBy = [ "multi-user.target" ];
      wants = [ "network.target" ];
      after = [ "network.target" ];
      preStart = "mkdir -p /var/spool";
      serviceConfig.ExecStart = "${opensmtpd}/sbin/smtpd -d -f ${conf} ${args}";
      environment.OPENSMTPD_PROC_PATH = "${procEnv}/libexec/opensmtpd";
    };

    environment.systemPackages = [ (pkgs.runCommand "opensmtpd-sendmail" {} ''
      mkdir -p $out/bin
      ln -s ${opensmtpd}/sbin/smtpctl $out/bin/sendmail
    '') ];
  };
}
