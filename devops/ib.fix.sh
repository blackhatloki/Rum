#!/bin/bash 
echo -n "`hostname` HCA-1" > /sys/class/infiniband/mlx5_0/device/infiniband/mlx5_0/node_desc
