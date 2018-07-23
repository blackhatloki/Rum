wwsh -y  node clone gpu-90 gpu-68
wwsh -y  node set gpu-68 --netdev=eth2 --hwaddr=24:6e:96:dd:35:1e
wwsh -y  node set gpu-68 -D eth2 -I 172.16.3.88
wwsh -y  node set gpu-68 -D ib0 -I 10.0.3.88
wwsh -y  object modify -s IPMI_IPADDR=192.168.3.88 gpu-68
wwsh -y  node set gpu-68 -D ib7 -I 10.0.7.88 -M 255.255.252.0
wwsh -y  provision set gpu-68 --fileadd ifcfg-ib0_0 
wwsh -y object modify -s diskformat=sda1,sda2,sdb1 gpu-68
wwsh -y object modify -s filesystems=mountpoint=/boot:dev=sda1:type=ext4:size=512,dev=sda2:type=swap:size=2048,mountpoint=/:dev=sda3:type=ext4:size=fill,mountpoint=/state/partition1:dev=sdb1:type=ext4:size=fill gpu-68 
wwsh -y  provision set gpu-68 --bootlocal=normal


wwsh -y  node clone gpu-90 gpu-69
wwsh -y  node set gpu-69 --netdev=eth2 --hwaddr=24:6e:96:dd:75:ee
wwsh -y  node set gpu-69 -D eth2 -I 172.16.3.89
wwsh -y  node set gpu-69 -D ib0 -I 10.0.3.89
wwsh -y  object modify -s IPMI_IPADDR=192.168.3.89 gpu-69
wwsh -y  node set gpu-69 -D ib7 -I 10.0.7.89 -M 255.255.252.0
wwsh -y  provision set gpu-69 --fileadd ifcfg-ib0_0 
wwsh -y object modify -s diskformat=sda1,sda2,sdb1 gpu-69
wwsh -y object modify -s filesystems=mountpoint=/boot:dev=sda1:type=ext4:size=512,dev=sda2:type=swap:size=2048,mountpoint=/:dev=sda3:type=ext4:size=fill,mountpoint=/state/partition1:dev=sdb1:type=ext4:size=fill gpu-69
wwsh -y  provision set gpu-69 --bootlocal=normal

wwsh -y  node clone gpu-90 gpu-70
wwsh -y  node set gpu-70 --netdev=eth2 --hwaddr=24:6e:96:dd:6e:3a
wwsh -y  node set gpu-70 -D eth2 -I 172.16.3.90
wwsh -y  node set gpu-70 -D ib0 -I 10.0.3.90
wwsh -y  object modify -s IPMI_IPADDR=192.168.3.90 gpu-70
wwsh -y  node set gpu-70 -D ib7 -I 10.0.7.90 -M 255.255.252.0
wwsh -y  provision set gpu-70 --fileadd ifcfg-ib0_0 
wwsh -y object modify -s diskformat=sda1,sda2,sdb1 gpu-70
wwsh -y object modify -s filesystems=mountpoint=/boot:dev=sda1:type=ext4:size=512,dev=sda2:type=swap:size=2048,mountpoint=/:dev=sda3:type=ext4:size=fill,mountpoint=/state/partition1:dev=sdb1:type=ext4:size=fill gpu-70
wwsh -y  provision set gpu-70 --bootlocal=normal

wwsh -y  node clone gpu-90 gpu-71
wwsh -y  node set gpu-71 --netdev=eth2 --hwaddr=24:6e:96:dd:6c:80
wwsh -y  node set gpu-71 -D eth2 -I 172.16.3.91
wwsh -y  node set gpu-71 -D ib0 -I 10.0.3.91
wwsh -y  object modify -s IPMI_IPADDR=192.168.3.91 gpu-71
wwsh -y  node set gpu-71 -D ib7 -I 10.0.7.91 -M 255.255.252.0
wwsh -y  provision set gpu-71 --fileadd ifcfg-ib0_0 
wwsh -y object modify -s diskformat=sda1,sda2,sdb1 gpu-71
wwsh -y object modify -s filesystems=mountpoint=/boot:dev=sda1:type=ext4:size=512,dev=sda2:type=swap:size=2048,mountpoint=/:dev=sda3:type=ext4:size=fill,mountpoint=/state/partition1:dev=sdb1:type=ext4:size=fill gpu-71
wwsh -y  provision set gpu-71 --bootlocal=normal

wwsh -y  node clone gpu-90 gpu-72
wwsh -y  node set gpu-72 --netdev=eth2 --hwaddr=24:6e:96:dd:34:b8
wwsh -y  node set gpu-72 -D eth2 -I 172.16.3.92
wwsh -y  node set gpu-72 -D ib0 -I 10.0.3.92
wwsh -y  object modify -s IPMI_IPADDR=192.168.3.92 gpu-72
wwsh -y  node set gpu-71 -D ib7 -I 10.0.7.92 -M 255.255.252.0
wwsh -y  provision set gpu-72 --fileadd ifcfg-ib0_0 
wwsh -y object modify -s diskformat=sda1,sda2,sdb1 gpu-72
wwsh -y object modify -s filesystems=mountpoint=/boot:dev=sda1:type=ext4:size=512,dev=sda2:type=swap:size=2048,mountpoint=/:dev=sda3:type=ext4:size=fill,mountpoint=/state/partition1:dev=sdb1:type=ext4:size=fill gpu-72
wwsh -y  provision set gpu-72 --bootlocal=normal

wwsh -y  node clone gpu-90 gpu-73
wwsh -y  node set gpu-73 --netdev=eth2 --hwaddr=24:6e:96:dd:67:52
wwsh -y  node set gpu-73 -D eth2 -I 172.16.3.93
wwsh -y  node set gpu-73 -D ib0 -I 10.0.3.93
wwsh -y  object modify -s IPMI_IPADDR=192.168.3.93 gpu-73
wwsh -y  node set gpu-73 -D ib7 -I 10.0.7.93 -M 255.255.252.0
wwsh -y  provision set gpu-73 --fileadd ifcfg-ib0_0 
wwsh -y object modify -s diskformat=sda1,sda2,sdb1 gpu-73
wwsh -y object modify -s filesystems=mountpoint=/boot:dev=sda1:type=ext4:size=512,dev=sda2:type=swap:size=2048,mountpoint=/:dev=sda3:type=ext4:size=fill,mountpoint=/state/partition1:dev=sdb1:type=ext4:size=fill gpu-73
wwsh -y  provision set gpu-73 --bootlocal=normal
