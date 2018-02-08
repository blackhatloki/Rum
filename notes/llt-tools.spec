# This is a sample spec file for wget

%define _topdir	 	/home/tteague4/rpmbuild
%define name	        llt-tools
%define release		1
%define version 	1.12
%define buildroot       %{_topdir}/%{name}-%{version}-root


Name: llt-tools
Version: 0.5
Release: 1
Summary: The llt-tools program
Distribution: Low Lacentency Team
Vendor:  Low Lacentency Team
Packager: Tony Teague
License: GPL
URL: http://nyl06i-9801.equity.csfb.com/llt/llt-tools    
Group: SERVER/System Environment/Base
## Group: Development/Tools
Prefix:   /app/t
Source0: http://nyl06i-9801.equity.csfb.com//llt/%{name}-%{version}.tar.gz
%description
The "LL-Tools" programs, tools for the LLT team

Group: Applications/Text

%changelog
* Wed Aug 4 2010 Tony Teague
- Initial version of the package

%prep
#%setup -q 
%setup 

%build
# %configure
mkdir -p /app/llt-tools-0.5
rm -rf $RPM_BUILD_ROOT


%install
DESTDIR=$RPM_BUILD_ROOT
##rm -rf $RPM_BUILD_ROOT
##install DESTDIR=$RPM_BUILD_ROOT
##%find_lang %{name}
## cp -rp  $DESTDIR /app/llt-tools-0.5
make install
%post
# /sbin/install-info %{_infodir}/%{name}.info %{_infodir}/dir || :

%preun
if [ $1 = 0 ] ; then
## /sbin/install-info --delete %{_infodir}/%{name}.info %{_infodir}/dir || :
fi

%clean
echo
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,tteague4,equities)
# /app/llt-tools-0.5
/app/llt-tools-0.5/
/app/llt-tools-0.5/installs_scripts/
/app/llt-tools-0.5/installs_scripts/armorday2.servers
/app/llt-tools-0.5/installs_scripts/install_firescope.sh
/app/llt-tools-0.5/installs_scripts/new
/app/llt-tools-0.5/profile_llt
/app/llt-tools-0.5/hp-utils/Drivers/
/app/llt-tools-0.5/hp-utils/Drivers/oa/
/app/llt-tools-0.5/hp-utils/Drivers/oa/hpoa241.bin
/app/llt-tools-0.5/hp-utils/Drivers/oa/hpoa252.bin
/app/llt-tools-0.5/hp-utils/Drivers/oa/hpoa260.bin
/app/llt-tools-0.5/hp-utils/Drivers/ilo/
/app/llt-tools-0.5/hp-utils/Drivers/ilo/ilo2_178.bin
/app/llt-tools-0.5/hp-utils/Drivers/ilo/ilo2_179.bin
/app/llt-tools-0.5/hp-utils/Drivers/sles9/
/app/llt-tools-0.5/hp-utils/Drivers/sles9/BL680G5/
/app/llt-tools-0.5/hp-utils/Drivers/sles9/BL680G5/CP011674.scexe
/app/llt-tools-0.5/hp-utils/Drivers/sles9/BL460G1/
/app/llt-tools-0.5/hp-utils/Drivers/sles9/BL460G1/CP011646.scexe
/app/llt-tools-0.5/hp-utils/Drivers/sles10/
/app/llt-tools-0.5/hp-utils/Drivers/sles10/BL465G1/
/app/llt-tools-0.5/hp-utils/Drivers/sles10/BL465G1/CP011557.scexe
/app/llt-tools-0.5/hp-utils/Drivers/sles10/BL465G1/CP011714.scexe
/app/llt-tools-0.5/hp-utils/Drivers/sles10/BL680G5/
/app/llt-tools-0.5/hp-utils/Drivers/sles10/BL680G5/CP011319.scexe
/app/llt-tools-0.5/hp-utils/Drivers/sles10/BL680G5/CP011627.scexe
/app/llt-tools-0.5/hp-utils/Drivers/sles10/BL680G5/CP011674.scexe
/app/llt-tools-0.5/hp-utils/Drivers/sles10/BL685G1/
/app/llt-tools-0.5/hp-utils/Drivers/sles10/BL685G1/CP011557.scexe
/app/llt-tools-0.5/hp-utils/Drivers/sles10/BL685G1/CP011701.scexe
/app/llt-tools-0.5/hp-utils/Drivers/sles10/DL380G6/
/app/llt-tools-0.5/hp-utils/Drivers/sles10/DL380G6/CP012402.scexe
/app/llt-tools-0.5/hp-utils/Drivers/sles10/DL580G5/
/app/llt-tools-0.5/hp-utils/Drivers/sles10/DL580G5/CP011677.scexe
/app/llt-tools-0.5/hp-utils/Drivers/sles10/DL580G5/CP012538.scexe
/app/llt-tools-0.5/hp-utils/Drivers/sles10/DL580G5/CP012063.scexe
/app/llt-tools-0.5/hp-utils/Drivers/sles10/DL580G5/firmware.update
/app/llt-tools-0.5/hp-utils/Drivers/sles10/BL460G1/
/app/llt-tools-0.5/hp-utils/Drivers/sles10/BL460G1/CP011187.scexe
/app/llt-tools-0.5/hp-utils/Drivers/sles10/BL460G1/CP011557.scexe
/app/llt-tools-0.5/hp-utils/ilo/
/app/llt-tools-0.5/hp-utils/ilo/locfg.pl
/app/llt-tools-0.5/hp-utils/ilo/License.xml
/app/llt-tools-0.5/hp-utils/ilo/Admin-Hotkey_Config.xml
/app/llt-tools-0.5/hp-utils/ilo/CSadmin-Hotkey_Config.xml
/app/llt-tools-0.5/hp-utils/ilo/Hotkey_Config.xml
/app/llt-tools-0.5/hp-utils/ilo/Rib-Hotkey_Config.xml
/app/llt-tools-0.5/hp-utils/ilo/Root-Hotkey_Config.xml
/app/llt-tools-0.5/hp-utils/ilo/Get_EmHealth.xml
/app/llt-tools-0.5/hp-utils/ilo/server.xml
/app/llt-tools-0.5/hp-utils/ilo/network.xml
/app/llt-tools-0.5/hp-utils/ilo/set-hotkeys
/app/llt-tools-0.5/hp-utils/ilo/set-ilonames
/app/llt-tools-0.5/hp-utils/ilo/set-licenses
/app/llt-tools-0.5/hp-utils/ilo/README.doc
/app/llt-tools-0.5/hp-utils/ilo/Set_Host_Power.xml
/app/llt-tools-0.5/hp-utils/ilo/Host_PowerOn.xml
/app/llt-tools-0.5/hp-utils/ilo/Host_PowerOff.xml
/app/llt-tools-0.5/hp-utils/ilo/global
/app/llt-tools-0.5/hp-utils/ilo/sor
/app/llt-tools-0.5/hp-utils/ilo/Administrator_reset_pw.xml
/app/llt-tools-0.5/hp-utils/ilo/Administrator_reset_pw_via_sysadmin.xml
/app/llt-tools-0.5/hp-utils/ilo/set-reset_Administrator
/app/llt-tools-0.5/hp-utils/ilo/Administrator_reset_pw_via_root.xml
/app/llt-tools-0.5/hp-utils/ilo/Administrator_reset_pw_via_csadmin.xml
/app/llt-tools-0.5/hp-utils/ilo/Get_Power_Readings.xml
/app/llt-tools-0.5/hp-utils/ilo/Get_Host_Power.xml
/app/llt-tools-0.5/hp-utils/ilo/dump/
/app/llt-tools-0.5/hp-utils/ilo/dump/kdump
/app/llt-tools-0.5/hp-utils/ilo/dump/notuse
/app/llt-tools-0.5/hp-utils/ilo/dump/add_sysrq
/app/llt-tools-0.5/hp-utils/ilo/dump/new
/app/llt-tools-0.5/hp-utils/ilo/dump/grub_fix
/app/llt-tools-0.5/hp-utils/ilo/dump/new2
/app/llt-tools-0.5/hp-utils/ilo/dump/setup-kdump
/app/llt-tools-0.5/hp-utils/ilo/dump/prod
/app/llt-tools-0.5/hp-utils/ilo/dump/new3
/app/llt-tools-0.5/hp-utils/ilo/dump/omega
/app/llt-tools-0.5/hp-utils/ilo/dump/sysstat.cron
/app/llt-tools-0.5/hp-utils/ilo/dump/sles10.1
/app/llt-tools-0.5/hp-utils/ilo/dump/nrpe.tar
/app/llt-tools-0.5/hp-utils/ilo/dump/List
/app/llt-tools-0.5/hp-utils/ilo/dump/add_clean_dump
/app/llt-tools-0.5/hp-utils/ilo/dump/aes.list
/app/llt-tools-0.5/hp-utils/ilo/dump/KKK
/app/llt-tools-0.5/hp-utils/ilo/dump/,
/app/llt-tools-0.5/hp-utils/ilo/dump/cdp.sh
/app/llt-tools-0.5/hp-utils/ilo/dump/omege.cdpsweep.cvs
/app/llt-tools-0.5/hp-utils/ilo/dump/o.csv
/app/llt-tools-0.5/hp-utils/ilo/dump/r.c
/app/llt-tools-0.5/hp-utils/ilo/dump/emm.raid
/app/llt-tools-0.5/hp-utils/ilo/dump/emm
/app/llt-tools-0.5/hp-utils/ilo/powerdown
/app/llt-tools-0.5/hp-utils/ilo/powerdown.jim.list
/app/llt-tools-0.5/hp-utils/ilo/get_emhealth.sh
/app/llt-tools-0.5/hp-utils/ilo/Administrator_reset_pw_unix.xml
/app/llt-tools-0.5/hp-utils/ilo/Linux
/app/llt-tools-0.5/hp-utils/ilo/emhealth_host_list
/app/llt-tools-0.5/hp-utils/ilo/temp
/app/llt-tools-0.5/hp-utils/ilo/Reset_Server.xml
/app/llt-tools-0.5/hp-utils/ilo/issues.stdout
/app/llt-tools-0.5/hp-utils/ilo/issues.stderr
/app/llt-tools-0.5/hp-utils/ilo/chk_host_poweron
/app/llt-tools-0.5/hp-utils/ilo/armorday2.servers
/app/llt-tools-0.5/hp-utils/ilo/junk
/app/llt-tools-0.5/hp-utils/ilo/Add_User.xml
/app/llt-tools-0.5/hp-utils/ilo/ribmon_add_user.xml
/app/llt-tools-0.5/hp-utils/ilo/add_sysrq
/app/llt-tools-0.5/hp-utils/ilo/Administrator_reset_pw_via_admin.xml
/app/llt-tools-0.5/hp-utils/ilo/rename-ilo
/app/llt-tools-0.5/hp-utils/ilo/Reset-Ilo.xml
/app/llt-tools-0.5/hp-utils/oa/
/app/llt-tools-0.5/hp-utils/oa/oa_cmds
/app/llt-tools-0.5/hp-utils/oa/expect_scripts/
/app/llt-tools-0.5/hp-utils/oa/expect_scripts/email.exp
/app/llt-tools-0.5/hp-utils/oa/expect_scripts/add_user_oa.exp
/app/llt-tools-0.5/hp-utils/oa/expect_scripts/ntp.exp
/app/llt-tools-0.5/hp-utils/oa/expect_scripts/show_config.exp
/app/llt-tools-0.5/hp-utils/oa/expect_scripts/show_enclosure_fan.exp
/app/llt-tools-0.5/hp-utils/oa/expect_scripts/show_enclosure_powersupply.exp
/app/llt-tools-0.5/hp-utils/oa/expect_scripts/show_interconnect_info.exp
/app/llt-tools-0.5/hp-utils/oa/expect_scripts/show_interconnect_list.exp
/app/llt-tools-0.5/hp-utils/oa/expect_scripts/show_interconnect_port_map.exp
/app/llt-tools-0.5/hp-utils/oa/expect_scripts/showoa.exp
/app/llt-tools-0.5/hp-utils/oa/expect_scripts/show_oa_status.exp
/app/llt-tools-0.5/hp-utils/oa/expect_scripts/show_server_info.exp
/app/llt-tools-0.5/hp-utils/oa/expect_scripts/show_server_list.exp
/app/llt-tools-0.5/hp-utils/oa/expect_scripts/emhealth.orig
/app/llt-tools-0.5/hp-utils/oa/expect_scripts/show_server_port_map.expect
/app/llt-tools-0.5/hp-utils/oa/expect_scripts/show_server_status.expect
/app/llt-tools-0.5/hp-utils/oa/expect_scripts/show_server_temp.expect
/app/llt-tools-0.5/hp-utils/oa/expect_scripts/show_user_list.expect
/app/llt-tools-0.5/hp-utils/oa/expect_scripts/sync_oa_blades_passwd.exp
/app/llt-tools-0.5/Libnet/
/app/llt-tools-0.5/Libnet/include/
/app/llt-tools-0.5/Libnet/include/libnet/
/app/llt-tools-0.5/Libnet/include/libnet/libnet-asn1.h
/app/llt-tools-0.5/Libnet/include/libnet/libnet-functions.h
/app/llt-tools-0.5/Libnet/include/libnet/libnet-headers.h
/app/llt-tools-0.5/Libnet/include/libnet/libnet-macros.h
/app/llt-tools-0.5/Libnet/include/libnet/libnet-structures.h
/app/llt-tools-0.5/Libnet/include/libnet.h
/app/llt-tools-0.5/Libnet/lib/
/app/llt-tools-0.5/Libnet/lib/libnet.a
/app/llt-tools-0.5/Libnet/man/
/app/llt-tools-0.5/Libnet/man/man3/
/app/llt-tools-0.5/Libnet/man/man3/libnet.3
/app/llt-tools-0.5/admin/
/app/llt-tools-0.5/admin/maxtime.pl
/app/llt-tools-0.5/admin/lists
/app/llt-tools-0.5/admin/Disk_Usage_Checker.pl
/app/llt-tools-0.5/admin/retransdiffs.pl
/app/llt-tools-0.5/admin/y
/app/llt-tools-0.5/admin/logs
/app/llt-tools-0.5/admin/checkOut.pl
/app/llt-tools-0.5/admin/CHECKMODULES/
/app/llt-tools-0.5/admin/CHECKMODULES/ntp.pl
/app/llt-tools-0.5/admin/CHECKMODULES/network.pl
/app/llt-tools-0.5/admin/CHECKMODULES/filesystem.pl
/app/llt-tools-0.5/admin/privelege-users
/app/llt-tools-0.5/admin/GENERIC.whocanlogin.pl
/app/llt-tools-0.5/admin/FULL-AES.txt
/app/llt-tools-0.5/admin/checkOut.pl.last
/app/llt-tools-0.5/aes
/app/llt-tools-0.5/bin/
/app/llt-tools-0.5/bin/iperf
/app/llt-tools-0.5/bin/netperf
/app/llt-tools-0.5/bin/netserver
/app/llt-tools-0.5/bin/uperf.solaris.sparc
/app/llt-tools-0.5/bin/inq.LinuxAMD64
/app/llt-tools-0.5/bin/inq.linux
/app/llt-tools-0.5/bin/lshw
/app/llt-tools-0.5/bin/udprecv
/app/llt-tools-0.5/bin/udpsend
/app/llt-tools-0.5/bin/mrsh
/app/llt-tools-0.5/bin/nicstat.Linux_i386
/app/llt-tools-0.5/bin/nicstat.SunOS_i386
/app/llt-tools-0.5/bin/nicstat.SunOS_sparc
/app/llt-tools-0.5/bin/curl
/app/llt-tools-0.5/bin/curl-config
/app/llt-tools-0.5/bin/wget
/app/llt-tools-0.5/bin/tcptraceroute
/app/llt-tools-0.5/bin/tcping
/app/llt-tools-0.5/share/
/app/llt-tools-0.5/share/man/
/app/llt-tools-0.5/share/man/man1/
/app/llt-tools-0.5/share/man/man1/iperf.1
/app/llt-tools-0.5/share/man/man1/netperf.1
/app/llt-tools-0.5/share/man/man1/netserver.1
/app/llt-tools-0.5/share/man/man1/curl.1
/app/llt-tools-0.5/share/man/man1/curl-config.1
/app/llt-tools-0.5/share/man/man3/
/app/llt-tools-0.5/share/man/man3/curl_easy_cleanup.3
/app/llt-tools-0.5/share/man/man3/curl_easy_getinfo.3
/app/llt-tools-0.5/share/man/man3/curl_easy_init.3
/app/llt-tools-0.5/share/man/man3/curl_easy_perform.3
/app/llt-tools-0.5/share/man/man3/curl_easy_setopt.3
/app/llt-tools-0.5/share/man/man3/curl_easy_duphandle.3
/app/llt-tools-0.5/share/man/man3/curl_formadd.3
/app/llt-tools-0.5/share/man/man3/curl_formfree.3
/app/llt-tools-0.5/share/man/man3/curl_getdate.3
/app/llt-tools-0.5/share/man/man3/curl_getenv.3
/app/llt-tools-0.5/share/man/man3/curl_slist_append.3
/app/llt-tools-0.5/share/man/man3/curl_slist_free_all.3
/app/llt-tools-0.5/share/man/man3/curl_version.3
/app/llt-tools-0.5/share/man/man3/curl_version_info.3
/app/llt-tools-0.5/share/man/man3/curl_escape.3
/app/llt-tools-0.5/share/man/man3/curl_unescape.3
/app/llt-tools-0.5/share/man/man3/curl_free.3
/app/llt-tools-0.5/share/man/man3/curl_strequal.3
/app/llt-tools-0.5/share/man/man3/curl_mprintf.3
/app/llt-tools-0.5/share/man/man3/curl_global_init.3
/app/llt-tools-0.5/share/man/man3/curl_global_cleanup.3
/app/llt-tools-0.5/share/man/man3/curl_multi_add_handle.3
/app/llt-tools-0.5/share/man/man3/curl_multi_cleanup.3
/app/llt-tools-0.5/share/man/man3/curl_multi_fdset.3
/app/llt-tools-0.5/share/man/man3/curl_multi_info_read.3
/app/llt-tools-0.5/share/man/man3/curl_multi_init.3
/app/llt-tools-0.5/share/man/man3/curl_multi_perform.3
/app/llt-tools-0.5/share/man/man3/curl_multi_remove_handle.3
/app/llt-tools-0.5/share/man/man3/curl_share_cleanup.3
/app/llt-tools-0.5/share/man/man3/curl_share_init.3
/app/llt-tools-0.5/share/man/man3/curl_share_setopt.3
/app/llt-tools-0.5/share/man/man3/libcurl.3
/app/llt-tools-0.5/share/man/man3/libcurl-easy.3
/app/llt-tools-0.5/share/man/man3/libcurl-multi.3
/app/llt-tools-0.5/share/man/man3/libcurl-share.3
/app/llt-tools-0.5/share/man/man3/libcurl-errors.3
/app/llt-tools-0.5/share/man/man3/curl_easy_strerror.3
/app/llt-tools-0.5/share/man/man3/curl_multi_strerror.3
/app/llt-tools-0.5/share/man/man3/curl_share_strerror.3
/app/llt-tools-0.5/share/man/man3/curl_global_init_mem.3
/app/llt-tools-0.5/share/man/man3/libcurl-tutorial.3
/app/llt-tools-0.5/share/man/man3/curl_easy_reset.3
/app/llt-tools-0.5/share/man/man3/curl_easy_escape.3
/app/llt-tools-0.5/share/man/man3/curl_easy_unescape.3
/app/llt-tools-0.5/share/man/man3/curl_multi_setopt.3
/app/llt-tools-0.5/share/man/man3/curl_multi_socket.3
/app/llt-tools-0.5/share/man/man3/curl_multi_timeout.3
/app/llt-tools-0.5/share/man/man3/curl_formget.3
/app/llt-tools-0.5/share/man/man3/curl_multi_assign.3
/app/llt-tools-0.5/share/man/man3/curl_easy_pause.3
/app/llt-tools-0.5/share/man/man3/curl_easy_recv.3
/app/llt-tools-0.5/share/man/man3/curl_easy_send.3
/app/llt-tools-0.5/share/man/man3/curl_multi_socket_action.3
/app/llt-tools-0.5/share/info/
/app/llt-tools-0.5/share/info/netperf.info
/app/llt-tools-0.5/Solaris/
/app/llt-tools-0.5/Solaris/diff3.SunOS
/app/llt-tools-0.5/Solaris/diff.SunOS
/app/llt-tools-0.5/Solaris/fping.SunOS
/app/llt-tools-0.5/Solaris/gtar.SunOS
/app/llt-tools-0.5/Solaris/lsof.SunOS.5.8.32.bit
/app/llt-tools-0.5/Solaris/md5sum.SunOS
/app/llt-tools-0.5/Solaris/merge.SunOS
/app/llt-tools-0.5/Solaris/netcat.SunOS
/app/llt-tools-0.5/Solaris/openssl.SunOS
/app/llt-tools-0.5/Solaris/rsync.SunOS
/app/llt-tools-0.5/Solaris/wget.SunOS
/app/llt-tools-0.5/Solaris/metachk.pl
/app/llt-tools-0.5/Solaris/metachk.sh
/app/llt-tools-0.5/Solaris/metainfo
/app/llt-tools-0.5/Solaris/metamap
/app/llt-tools-0.5/Solaris/metastat-check.sh
/app/llt-tools-0.5/Solaris/ods_mirror
/app/llt-tools-0.5/Solaris/ciscosnoop
/app/llt-tools-0.5/Solaris/checkcable
/app/llt-tools-0.5/Solaris/sol10x86_hppro_hwmon.pl
/app/llt-tools-0.5/Solaris/solaris10x86-hwraidstatus
/app/llt-tools-0.5/Solaris/inq.sol64
/app/llt-tools-0.5/Solaris/nis_pull.sh
/app/llt-tools-0.5/Solaris/show_devalias
/app/llt-tools-0.5/Solaris/swapf
/app/llt-tools-0.5/Solaris/check-disksuite-disks.pl
/app/llt-tools-0.5/Solaris/nicstatus
/app/llt-tools-0.5/engr/
/app/llt-tools-0.5/engr/tcpdump
/app/llt-tools-0.5/engr/telnet
/app/llt-tools-0.5/engr/traceroute
/app/llt-tools-0.5/engr/udprecv
/app/llt-tools-0.5/engr/udpsend
/app/llt-tools-0.5/engr/netcat.bin
/app/llt-tools-0.5/engr/tcptraceroute
/app/llt-tools-0.5/engr/curl
/app/llt-tools-0.5/engr/curl-config
/app/llt-tools-0.5/engr/inq.LinuxAMD64
/app/llt-tools-0.5/engr/inq.linux
/app/llt-tools-0.5/engr/iperf
/app/llt-tools-0.5/engr/lshw
/app/llt-tools-0.5/engr/mrsh
/app/llt-tools-0.5/engr/netperf
/app/llt-tools-0.5/engr/netserver
/app/llt-tools-0.5/engr/nicstat.Linux_i386
/app/llt-tools-0.5/engr/nicstat.SunOS_i386
/app/llt-tools-0.5/engr/nicstat.SunOS_sparc
/app/llt-tools-0.5/engr/uperf.solaris.sparc
/app/llt-tools-0.5/engr/wget
/app/llt-tools-0.5/engr/tcping
/app/llt-tools-0.5/engr/Get_EmHealth.xml
/app/llt-tools-0.5/engr/locfg.pl
/app/llt-tools-0.5/engr/garp.sh
/app/llt-tools-0.5/engr/gather_ullfx.sh
/app/llt-tools-0.5/installation.tar
/app/llt-tools-0.5/fix
/app/llt-tools-0.5/nfds_off
/app/llt-tools-0.5/fix2
/app/llt-tools-0.5/fping/
/app/llt-tools-0.5/fping/sbin/
/app/llt-tools-0.5/fping/sbin/fping
/app/llt-tools-0.5/fping/sbin/i
/app/llt-tools-0.5/fping/man/
/app/llt-tools-0.5/fping/man/man8/
/app/llt-tools-0.5/fping/man/man8/fping.8
/app/llt-tools-0.5/turn_on_nscd
/app/llt-tools-0.5/turn_off_nscd
/app/llt-tools-0.5/netcat/
/app/llt-tools-0.5/netcat/bin/
/app/llt-tools-0.5/netcat/bin/netcat
/app/llt-tools-0.5/netcat/bin/nc
/app/llt-tools-0.5/netcat/info/
/app/llt-tools-0.5/netcat/info/netcat.info
/app/llt-tools-0.5/netcat/info/dir
/app/llt-tools-0.5/netcat/man/
/app/llt-tools-0.5/netcat/man/man1/
/app/llt-tools-0.5/netcat/man/man1/netcat.1
/app/llt-tools-0.5/netcat/share/
/app/llt-tools-0.5/netcat/share/locale/
/app/llt-tools-0.5/netcat/share/locale/it/
/app/llt-tools-0.5/netcat/share/locale/it/LC_MESSAGES/
/app/llt-tools-0.5/netcat/share/locale/it/LC_MESSAGES/netcat.mo
/app/llt-tools-0.5/netcat/share/locale/sk/
/app/llt-tools-0.5/netcat/share/locale/sk/LC_MESSAGES/
/app/llt-tools-0.5/netcat/share/locale/sk/LC_MESSAGES/netcat.mo
/app/llt-tools-0.5/scripts/
/app/llt-tools-0.5/scripts/hwraidinfo
/app/llt-tools-0.5/scripts/hwraidstatus
/app/llt-tools-0.5/scripts/metatree.sh
/app/llt-tools-0.5/scripts/cpio-archive
/app/llt-tools-0.5/scripts/ethstatus.sh
/app/llt-tools-0.5/scripts/cdpinfo.pl
/app/llt-tools-0.5/scripts/hppro_hwmon.pl
/app/llt-tools-0.5/scripts/checkout_report
/app/llt-tools-0.5/scripts/server_info
/app/llt-tools-0.5/scripts/silent
/app/llt-tools-0.5/scripts/hostcli
/app/llt-tools-0.5/scripts/pci_slot.dl585.g5
/app/llt-tools-0.5/scripts/report.sh
/app/llt-tools-0.5/scripts/vcs_sweep
/app/llt-tools-0.5/scripts/48hours
/app/llt-tools-0.5/scripts/san_check.sles10
/app/llt-tools-0.5/scripts/loop-remote
/app/llt-tools-0.5/scripts/sol.dmp.check
/app/llt-tools-0.5/scripts/sol.san.check
/app/llt-tools-0.5/scripts/24hours
/app/llt-tools-0.5/scripts/gen-interface-info
/app/llt-tools-0.5/scripts/lun_scan
/app/llt-tools-0.5/scripts/dmp_check
/app/llt-tools-0.5/scripts/raid_check
/app/llt-tools-0.5/scripts/nicstatus
/app/llt-tools-0.5/scripts/mkpasswd
/app/llt-tools-0.5/scripts/metainfo
/app/llt-tools-0.5/scripts/cmd
/app/llt-tools-0.5/scripts/ipcalc
/app/llt-tools-0.5/scripts/cpio-archive-app
/app/llt-tools-0.5/scripts/vxfree
/app/llt-tools-0.5/scripts/vxtree.pl
/app/llt-tools-0.5/scripts/san_check.sles9
/app/llt-tools-0.5/scripts/get_cdp_info.solaris
/app/llt-tools-0.5/scripts/hostcli.orig
/app/llt-tools-0.5/scripts/h
/app/llt-tools-0.5/scripts/12hours
/app/llt-tools-0.5/scripts/san_check.sles
/app/llt-tools-0.5/scripts/blackout_for_2weeks
/app/llt-tools-0.5/scripts/vip
/app/llt-tools-0.5/scripts/options
/app/llt-tools-0.5/scripts/setup/
/app/llt-tools-0.5/scripts/setup/set-eqfn
/app/llt-tools-0.5/scripts/setup/create-bond0
/app/llt-tools-0.5/scripts/setup/create-eqfn
/app/llt-tools-0.5/scripts/setup/create-llthosts
/app/llt-tools-0.5/scripts/setup/create-llttab
/app/llt-tools-0.5/scripts/setup/list5
/app/llt-tools-0.5/scripts/setup/copy-eqfn
/app/llt-tools-0.5/scripts/setup/ifcfg-bond0-template
/app/llt-tools-0.5/scripts/setup/ifcfg-eqfn-template
/app/llt-tools-0.5/scripts/setup/llttab-template
/app/llt-tools-0.5/scripts/setup/create-eqfn-lohi
/app/llt-tools-0.5/scripts/setup/create-trade
/app/llt-tools-0.5/scripts/setup/copy-interface-eqfn
/app/llt-tools-0.5/scripts/setup/start_ncsd
/app/llt-tools-0.5/scripts/setup/stop_nfsd
/app/llt-tools-0.5/scripts/setup/eq.junk.1
/app/llt-tools-0.5/scripts/setup/stop_ncsd
/app/llt-tools-0.5/scripts/setup/eq.junk.2
/app/llt-tools-0.5/scripts/setup/copy-interface-eqhilo
/app/llt-tools-0.5/scripts/setup/up-eqhilo-interfaces
/app/llt-tools-0.5/scripts/setup/ifcfg-trade-template
/app/llt-tools-0.5/scripts/setup/copy-interface
/app/llt-tools-0.5/scripts/chg_vcs_notify
/app/llt-tools-0.5/scripts/set-application-id
/app/llt-tools-0.5/scripts/2hours
/app/llt-tools-0.5/scripts/2weeks
/app/llt-tools-0.5/scripts/cdp.sh.org
/app/llt-tools-0.5/scripts/cdp.sh
/app/llt-tools-0.5/scripts/ethstatus.sh.org
/app/llt-tools-0.5/scripts/change_vcs_ntfr
/app/llt-tools-0.5/scripts/run-stats
/app/llt-tools-0.5/scripts/sweep
/app/llt-tools-0.5/scripts/cdp.d
/app/llt-tools-0.5/scripts/optios
/app/llt-tools-0.5/scripts/Savvis.Solaris
/app/llt-tools-0.5/scripts/Savvis.linux
/app/llt-tools-0.5/scripts/sol.san.check.old
/app/llt-tools-0.5/scripts/san_filter
/app/llt-tools-0.5/nfsd
/app/llt-tools-0.5/do
/app/llt-tools-0.5/configure
/app/llt-tools-0.5/Makefile
