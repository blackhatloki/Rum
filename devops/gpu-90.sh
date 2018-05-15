wwsh -y  node clone gpu-13 gpu-90
wwsh -y  node set gpu-90 --netdev=eno1 --hwaddr=44:a8:42:10:93:0c
wwsh -y  node set gpu-90 -D eno1 -I 172.16.3.87
wwsh -y  node set gpu-90 -D ib0 -I 10.0.3.87
wwsh -y  object modify -s IPMI_IPADDR=192.168.3.87 gpu-90
wwsh -y  node set gpu-90 -D ib7 -I 10.0.7.87 -M 255.255.252.0
wwsh -y  provision set gpu-90 --fileadd ifcfg-ib0_0 
wwsh -y object modify -s diskformat=sda1,sda2,sdb1 gpu-90
wwsh -y object modify -s filesystems=mountpoint=/boot:dev=sda1:type=ext4:size=512,dev=sda2:type=swap:size=2048,mountpoint=/:dev=sda3:type=ext4:size=fill,mountpoint=/state/partition1:dev=sdb1:type=ext4:size=fill gpu-90 
wwsh -y  provision set gpu-90 --bootlocal=normal
