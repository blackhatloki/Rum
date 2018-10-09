%define dvendor	qlgc
%define vendor %{dvendor}
%define driver_name fastlinq
%define dist_version	8.24.8.2
%define fw_version	8.24.0.0
%define dist_str	rhel7u5
%define d_version	%( echo "%{dist_version}" | tr '-' '_' )
%define qed_ver	8.24.8.0
%define qede_ver	8.24.8.0
%define qedr_ver	8.24.8.0
%define qedf_ver	8.24.8.1
%define qedi_ver	8.24.8.0


%define release	1

%define mod_sign_files /home/sign
%define module_key %{mod_sign_files}/qlgc_module_signing_key.priv
%define module_cer %{mod_sign_files}/qlgc_module.cer
%define gpginfo "RPM public key available at http://ldriver.qlogic.com/RPM-public-key/ and Module public key available at http://ldriver.qlogic.com/Module-public-key/"


Name	: %{vendor}-%{driver_name}
Version  : %{d_version}
Release  : %{release}.%{dist_str}
Group    : System Environment/Base
Vendor   : QLogic Corporation
URL	 : http://www.qlogic.com
License  : GPLv2
Source0  : %{driver_name}-%{d_version}.tgz
Source1  : kmodtool-ql.fl.7.x.sh
Source2  : %{driver_name}.files
Source3  : qed_init_values_zipped-%{fw_version}.bin
Source4  : dracut.fastlinq.conf
BuildRoot: %{_tmppath}/%{name}-buildroot
BuildRequires: %kernel_module_package_buildreqs
Summary  : QLogic fastlinq CNA drivers

%kernel_module_package -s %{_sourcedir}/kmodtool-ql.fl.7.x.sh -f %{SOURCE2}

%description
RHEL7.x Driver Update package for QLogic fastlinq CNA drivers.
Public key available at http://ldriver.qlogic.com/RPM-public-key/
SRPMS available at http://ldriver.qlogic.com/driver-srpms/

%prep
%setup -n %{driver_name}-%{dist_version}
set -- *
mkdir source
mv "$@" source/
cp %{S:3} .

mkdir obj
echo "override qed * weak-updates/%{dvendor}-%{driver_name}" > %{driver_name}.conf
echo "override qede * weak-updates/%{dvendor}-%{driver_name}" >> %{driver_name}.conf
echo "override qedr * weak-updates/%{dvendor}-%{driver_name}" >> %{driver_name}.conf
echo "override qedi * weak-updates/%{dvendor}-%{driver_name}" >> %{driver_name}.conf
echo "override qedf * weak-updates/%{dvendor}-%{driver_name}" >> %{driver_name}.conf

%build

for flavor in %{flavors_to_build}; do
  rm -rf obj/$flavor
  cp -r source obj/$flavor
  cd obj/$flavor
  make OVERRIDE_CRC8=1 M=$PWD
done

%install
export KVER=%{kverrel}

for flavor in %{flavors_to_build};
do
	if [ -f %{module_key} ] && [ -f %{module_cer} ]; then
		perl /usr/src/kernels/`uname -r`/scripts/sign-file sha256 %{module_key} %{module_cer}  $PWD/obj/$flavor/qed-%{qed_ver}/src/qed.ko
		perl /usr/src/kernels/`uname -r`/scripts/sign-file sha256 %{module_key} %{module_cer}  $PWD/obj/$flavor/qede-%{qede_ver}/src/qede.ko
		if [ -f obj/${flavor}/qedr-%{qedr_ver}/src/qedr.ko ]; then
			 perl /usr/src/kernels/`uname -r`/scripts/sign-file sha256 %{module_key} %{module_cer}  $PWD/obj/${flavor}/qedr-%{qedr_ver}/src/qedr.ko $dest_dir
		fi

		if [ -f obj/${flavor}/qedi-%{qedi_ver}/qedi.ko ]; then
			 perl /usr/src/kernels/`uname -r`/scripts/sign-file sha256 %{module_key} %{module_cer}  $PWD/obj/${flavor}/qedi-%{qedi_ver}/qedi.ko $dest_dir
		fi

		if [ -f obj/${flavor}/qedf-%{qedf_ver}/qedf.ko ]; then
			 perl /usr/src/kernels/`uname -r`/scripts/sign-file sha256 %{module_key} %{module_cer}  $PWD/obj/${flavor}/qedf-%{qedf_ver}/qedf.ko $dest_dir
		fi

	fi

	if [ $flavor == "default" ]; then
		kernel_flavor=${KVER}
	else
		kernel_flavor=${KVER}${flavor}
	fi

	dest_dir=${RPM_BUILD_ROOT}/lib/modules/$kernel_flavor/extra/%{name}

	mkdir -p $dest_dir
	install -m 444 obj/${flavor}/qed-%{qed_ver}/src/qed.ko $dest_dir
	install -m 444 obj/${flavor}/qede-%{qede_ver}/src/qede.ko $dest_dir

	if [ -f obj/${flavor}/qedr-%{qedr_ver}/src/qedr.ko ]; then
		install -m 444 obj/${flavor}/qedr-%{qedr_ver}/src/qedr.ko $dest_dir
	fi

	if [ -f obj/${flavor}/qedi-%{qedi_ver}/qedi.ko ]; then
		install -m 444 obj/${flavor}/qedi-%{qedi_ver}/qedi.ko $dest_dir
	fi

	if [ -f obj/${flavor}/qedf-%{qedf_ver}/qedf.ko ]; then
		install -m 444 obj/${flavor}/qedf-%{qedf_ver}/qedf.ko $dest_dir
	fi

done

install -m 644 -D %{driver_name}.conf $RPM_BUILD_ROOT/etc/depmod.d/%{driver_name}.conf

mkdir -p $RPM_BUILD_ROOT/lib/firmware/qed
install -m 644 -D qed_init_values_zipped-%{fw_version}.bin $RPM_BUILD_ROOT/lib/firmware/qed/qed_init_values_zipped-%{fw_version}.bin
install -m 644 -D %{SOURCE4} $RPM_BUILD_ROOT/etc/dracut.conf.d/fastlinq.conf

%clean
rm -rf %{buildroot}
rm -rf $RPM_BUILD_ROOT

%changelog
* Thu Mar 23 2017 QLogic Cavium Build environment
- Version 8.18.18.0
- Added missing support to configure 1G speed via ethtool
- Fixed calculation of number of ooo rx buffers and limit to 16K

- Version 8.18.17.0-1
- iWARP - Handle flush completion on unaligned ll2 connection
- Add dp_module, dp_level as modparams
- Add Kconfig file for upstream builds

- Version 8.18.16.0-1
- Fix missing return error code check on call to qedi_setup_int
- Modify different module params
- Add log message in the driver unload path
- Fail all non-timesync related ioctls

- Version 8.18.15.0-1
- Added wwpn and wwnn to the FCoE dev-info
- Validate chap and mutual chap auth correctly

- Version 8.18.14.0-1
- Fix error handling flow in TX path
- Fix error handling flow in RX path
- Implement get_protocol_tlv_data callback

