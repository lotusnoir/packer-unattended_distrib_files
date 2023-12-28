# packer-unattended_distrib_files

In this repository, you will find some files that contains answers to automatic distribution installs.

This files are templates for packer and packer must send value for variables.

We assume in this repository that
    - we dont use dhcp and we specify static network informations.
    - packer is in charge of the provisioning so files instructions are minimalist.
    - we use boot iso on not dvd ones to save space

For each distrib we will show an exemple of packer configuration in order to deploy and reuse this files for multiple sites.

## Debian



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
