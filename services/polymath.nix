{ pkgs }: {
    description = "PROGRAMMESWAG";
    after = [ "network.target" ];

    serviceConfig = {
        Type = "simple";
        User = "thomas";
        ExecStart = "${pkgs.python3}/bin/python ./server.py";
        WorkingDirectory = "/home/thomas/services/polymath";
        Restart = "on-failure";
    };

    environment = {
        JAVA_HOME = pkgs.python3;
    };

    wantedBy = [ "multi-user.target" ];
}