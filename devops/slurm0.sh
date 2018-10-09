wwsh -y node new slurm0  --ipaddr=172.16.3.94 --hwaddr=f4:e9:d4:76:2b:9a -D eth0 --groups=slurm
# wwsh -y node set slurm0 -D ib0 -I 10.0.3.94 -M  255.255.252.0
wwsh -y object modify -s IPMI_IPADDR=192.168.3.94 slurm0
# wwsh -y node set slurm0 -D ib7 -I 10.0.7.94 -M 255.255.252.0
wwsh -y provision set slurm0 --vnfs=2018-06-12 --bootstrap=`uname -r`  --files=dynamic_hosts,passwd,group,shadow,network,ifcfg-ib0,ifcfg-ib0_0
wwsh -y provision set --filesystem=bios slurm0
wwsh -y provision set --bootloader=sda slurm0
wwsh -y provision set slurm0 --bootlocal=normal
