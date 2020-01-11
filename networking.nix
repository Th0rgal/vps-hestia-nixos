{ lib, ... }: {

  networking = {
    hostName = "hestia";

    firewall = {
      allowPing = true;
      allowedTCPPorts = [ 8080 ];
    };

    localCommands = ''
    ip tunnel add he-ipv6 mode sit remote 216.66.84.42 ttl 255
    ip link set he-ipv6 up
    ip addr add 2001:470:1f12:328::2/64 dev he-ipv6
    ip route add ::/0 dev he-ipv6 pref high
    '';
  };

  # openssh daemon
  services.openssh.enable = true;

}