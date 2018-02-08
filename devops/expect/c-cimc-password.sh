#!/usr/bin/expect --
#
# c-cimc-sensor.sh
#
# Execute a show for a specific cimc sensor
#
# John McDonough (jomcdono)
#
# Cisco proprietary, not for distribution outside of Cisco, 
# not for use by non Cisco personnel

set timeout -1
set cimcUser [lindex $argv 0]
set cimcPass [lindex $argv 1]
set cimcHost [lindex $argv 2]

#check if all were provided
if { $cimcUser == "" || $cimcPass == "" || $cimcHost == ""  }  {
  puts "\n   Usage: $argv0 <User> <Pass> <Host> <Sensor> \n"
  puts "   Where:\n"
  puts "         User - CIMC user name"
  puts "         Pass - CIMC user password"
  puts "         Host - CIMC host\n"

  exit 1
}

# Open and ssh connection to CIMC
spawn ssh $cimcUser@$cimcHost
expect {
   "Are you sure you want to continue connecting*" {
      send "yes\r"
      expect "*assword:"
      send "$cimcPass\r"
   }
   "*assword:" {
      send "$cimcPass\r"
   }
}
expect "# "

# Connect to the local-mgmt context
send "scope sensor\r"
expect "sensor #"

send "show $cimcSensor | no-more\r"

expect "sensor #"

# Finished
exit 0
