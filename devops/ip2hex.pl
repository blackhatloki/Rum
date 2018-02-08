#!/usr/bin/perl

($p1, $p2, $p3, $p4) = split(/\./, $ARGV[0]);
printf "%lx%lx%lx%lx\n",$p1,$p2,$p3,$p4;

