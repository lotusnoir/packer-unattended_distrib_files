# packer-unattended_distrib_files

In this repository, you will find some files that contains answers to automatic distribution installs.

This files are templates for packer and packer must send value for variables.

We assume in this repository that
    - we dont use dhcp and we specify static network informations.
    - packer is in charge of the provisioning so files instructions are minimalist.
    - we use boot iso on not dvd ones to save space

For each distrib we will show an exemple of packer configuration in order to deploy and reuse this files for multiple sites.

## Debian

### Use a netboot deploy with http preseed file
iso_checksum = "712cf43c5c9d60dbd5190144373c18b910c89051193c47534a68b0cd137c99bd8274902f59b25aba3b6ba3e5bca51d7c433c06522f40adb93aacc5e21acf57eb"
iso_url      = "https://miroir.univ-lorraine.fr/debian-cd/current/amd64/iso-cd/debian-12.6.0-amd64-netinst.iso"
http_content_filename      = "preseed.cfg"
http_content_filename_path = "../../modules/packer-unattended_distrib_files/linux/debian/preseed.pkrtpl"
boot_command = [
  "<esc><wait>",
  "auto <wait>",
  "netcfg/disable_autoconfig=true ",
  "netcfg/use_autoconfig=false ",
  "netcfg/get_ipaddress=10.4.255.3 ",
  "netcfg/get_netmask=255.255.255.240 ",
  "netcfg/get_gateway=10.4.255.1 ",
  "netcfg/get_nameservers=10.1.80.155 ",
  "netcfg/confirm_static=true <wait>",
  "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg <wait>",
  "<enter><wait>"
]


### Use de dvd with no mirror deploy and cdrom
iso_checksum = "c79e2532fd3cf40b171a7a89a7de8cff37cb333c85870104b72f8e3e2d150f3321a683a556f5fd4ee204dcba288655af7793faa25a6166bf1e31cced4db1611c"
iso_url      = "https://miroir.univ-lorraine.fr/debian-cd/current/amd64/iso-dvd/debian-12.7.0-amd64-DVD-1.iso"
remove_cdrom = true
cd_label = "cidata"
cd_content_filename = "preseed.cfg"
cd_content_filename_path = "../../modules/packer-unattended_distrib_files/linux/debian/preseed_standalone.pkrtpl"
boot_command =  [
  "<esc><wait>install <wait>auto=true priority=critical file=/mnt/cdrom2/preseed.cfg <wait>",
  "netcfg/disable_autoconfig=true ",
  "netcfg/use_autoconfig=false ",
  "netcfg/get_ipaddress=100.64.0.66 ",
  "netcfg/get_netmask=255.255.255.240 ",
  "netcfg/get_gateway=100.64.0.65 ",
  "netcfg/get_nameservers=8.8.8.8 ",
  "netcfg/confirm_static=true <wait>",
  "<wait><enter><wait5>",
  "<leftAltOn><f2><leftAltOff>",
  "<wait><enter><wait>",
  "mkdir /mnt/cdrom2<enter><wait>",
  "mount /dev/sr1 /mnt/cdrom2<enter><wait>",
  "<leftAltOn><f1><leftAltOff><wait>",
  "<enter><wait><enter><wait>",
  "<down><down><down><down><enter>",
]

## Ubuntu



## OracleLinux


    iso_checksum = "22c68f84230b375aeb8fa035fab6f5f4ef6505c036ee068cd8fab5f0675b2c78"
    iso_url = "https://yum.oracle.com/ISOS/OracleLinux/OL9/u3/x86_64/OracleLinux-R9-U3-x86_64-boot.iso"
    internet_install = true
    http_proxy = http://1.2.3.4:3128

if you want to serev the kickstart file in http

    http_content = true
    http_content_filename      = "ks9.cfg"
    http_content_filename_path = "../../modules/packer-unattended_distrib_files/linux/oraclelinux/ks9.pkrtpl"

In case you dont use dhcp, you will need to set the boot command with a static ip or the vm will not be able to get the file

    boot_command = ["<up><tab> ip=10.4.255.4::10.4.255.1:255.255.255.240:ora8:ens192:none nameserver=10.1.80.155 inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks9.cfg proxy=\"http://10.1.80.5:80\"<enter><wait><enter>"]

## Windws
