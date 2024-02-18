{ config, pkgs, user, ... }:
{
  users.groups = {
      libvirt.members = [ "root" "lazyhoge" ];
      kvm.members = [ "root" "lazyhoge" ];
    };

  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown ="shutdown";
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };


  # Install necessary packages
 
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    virtio-win
    win-spice
    gnome.adwaita-icon-theme
    dmidecode
  ];

  # Manage the virtualisation services
  services.spice-vdagentd.enable = true;


}
