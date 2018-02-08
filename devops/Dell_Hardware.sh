#!/bin/bash
 
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Company name - Division name - Project name
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# HallOfTips - 04/05/2012 - HardChk.bash - 1.8
# ---------------------------------
# This script use the dell omreport & omconfig to check hardware status
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
#####################################
##### HOW-TO
#####################################
# This script print its results to a text file ($TmpFile), that is either sent as an email (default behaviour) or printed to stdout (using the "-p" option).
#+ It could also clear given logs with the "-c <log_name>" option
#
# Each hardware components status are retrieved using the omreport dell utility, for each hardware component the status might of 4 kind :
#   1 - Ok           = The component is in perfect condition
#   2 - Non-Critical = The component is NOT in perfect condition but is also not about to fail
#   3 - Critical     = The component might be about to fail, you should fix the reported problem ASAP !
#   4 - Not found    = The component was not found, this is the standard behaviour from the omreport utility
 
#####################################
##### TODO
#####################################
 
#####################################
##### ChangeLog
#####################################
 
###### V1.8 (30/07/12)
# - Modded most of the shitty construct ""while read" +"echo line" + "read $line""
# - Added tac command to reverse the log display
 
###### V1.7 (25/07/12)
# - Added BIOS settings check (Maximum Performance as power management profile)
# - Added CPU settings check (Turbo Mode & HyperThreading)
 
###### V1.6 (29/06/12)
# - Added "ESMLOG" domain (check the esmlog)
 
###### V1.5 (25/06/12)
# - Added "-c" option (clear logs)
 
###### V1.4 (14/06/12)
# - Added "-p" option for local mode : this mode print out the results AND send the email (This needs to be changed, there is no need to send the email in this mode)
# - Added the Usage function
# - Minor bug corrected (for level_4 cmd)
 
###### V1.3 (08/06/12)
# - Added ${Serial_number} to SystemInfo() + changed from echo to cat <<HEREDOC
 
###### V1.2 (11/05/12)
# - Added Email object matching the worst status (Ok, Non-Critical, Critical)
 
###### V1.1 (10/05/12)
# - Added server model + OS version to email body
 
#####################################
##### VARIABLES
#####################################
 
PATH=$PATH:/usr/bin:/opt/dell/srvadmin/bin/
export PATH
 
ADMIN="user@company.fr"
 
Local_mode="0"
Fatal_Error="66"
E_OPTERROR="42"
Network_file="/etc/sysconfig/network-scripts/ifcfg-eth0"
OsRelease=$(cat /etc/redhat-release)
Ip_address=$(grep "IPADDR=" "${Network_file}" |cut -d"=" -f2)
TmpDir="/tmp"
TmpFile="${TmpDir}/HardChk_EMAIL_${HostName}_$(date +%Y-%m-%d)_$$"
NonCritical="2"
Critical="3"
OkMsg="Nothing to report"
NonCriticalMsg=" - Warning : At least one components status is \"Non-Critical\" - "
CriticalMsg="=== FAILURE : At least one components status is \"Critical\" ! ==="
DomainEnd="~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
RETCODE="0"
LENGHT="80"
Logs_names=( esmlog alertlog cmdlog ) # useless for now
 
MAILHOST="mailhost.company.fr"
 
#####################################
##### USAGE
#####################################
 
# usage & examples
Usage() {
  cat <<EOF
Usage: $(basename $0) [-ph] [-c] [log_name]
 
Options :
          -p : print output to stdout
          -h : print this message (help)
          -c : clear <log_name> given as parameter, where <log_name> must be one (and ONLY one at a time!) of : $(echo "${Logs_names[@]}")
 
Examples:
          1) To check one server hardware state and send the results to the administrator (currently $ADMIN) : "$(basename $0)"
          2) To check one server hardware state and print the results to stdout (screen) : "$(basename $0) -p"
          3) To clear one server log : "$(basename $0) -c <log_name>"
EOF
  exit $E_OPTERROR
}
 
#####################################
##### PRIMARY FUNCTIONS
#####################################
 
# This function is used to clear logs
Log_Clear() {
  # Usage: $0 called with the "logs names" as $@ (as a list), "logs names" could be any of the following : "esmlog" "alertlog" "cmdlog"
  logs_array=( ${@} )
  for logs in ${logs_array[@]} ; do
    omconfig system ${logs} action=clear
  done
  exit 0
}
 
#####################################
##### OPTION MANAGEMENT
#####################################
 
# Process options analysis
while getopts ":phc:" Option ; do
# Declaration initiale.
# Le ":" après l'option 'c' montre qu'il y aura un argument associé : $OPTARG
# le ":" en premiere position defini (peut-etre, a verifier) que le cas "*" est géré par nous ou l'inverse, encore une fois c'est a verifier
 
  case $Option in
    p ) Local_mode="1" && echo "-> Local mode is activated : all results will be printed on stdout" # Send $TmpFile to STDOUT
    ;;
    c ) Log_Clear "${OPTARG}"
    ;;
    h ) Usage && exit $E_OPTERROR
    ;;
    \? ) echo "Invalid option: -$OPTARG" >&2 && Usage && exit $E_OPTERROR # this handle the "invalid option" case
    ;;
    : ) echo "Option -${OPTARG} requires an argument (\"$(echo ${Logs_names[@]})\")" >&2 && Usage && exit $E_OPTERROR # this handle the "invalid parameter for this option" case
    ;;
  esac
done
 
#####################################
##### FUNCTIONS
#####################################
 
# The cleaning function cleans everything after the script is terminated, either for regular termination or interruption. It is called by the trap command
Cleaning() {
 echo "Cleaning before exiting..."
 rm -f ${TmpFile}
 exit 0
}
 
# This is the function that print AND log any errors occuring during $0 execution: print $1 on screen AND print $2 (the message) in $ErrorLog)
# ErrorPrintandlog () {
# if [[ "${1}" = "${F_Error}" ]] ; then
#   echo  "=> FATAL_ERROR, exiting (see ${ErrorLog} for more infos)" && echo "${2}" >> ${ErrorLog} && exit ${F_Error}
# elif [[ "${1}" = "${Error}" ]] ; then
#   echo  "=> ERROR (see ${ErrorLog} for more infos)" && echo "${2}" >> ${ErrorLog}
# fi
# }
 
# Generate the ${TmpFile} header
MailHeader() {
  echo "This is an automatically generated email by \"$0\" from \"${HOSTNAME}\" (on $(date +%d-%m-%Y)" @ $(date +%H:%M)\) >> ${TmpFile}
}
 
# Generate the ${TmpFile} footer
MailFooter() {
  echo -e "\n\n--> For more information you should check the Dell Open Manage web interface (using this command : \"firefox https://${Ip_address}:1311\" )" >> ${TmpFile}
}
 
# Generate the email "object field" according to the worst status of checked components
AddToMailObject() {
# (Return code = 2) : "non-Critical" status only ;
#+ (Return code = 3) : at least- 1 "Critical" status
  ReturnCode="${1}"
  if [[ "${ReturnCode}" = "0" ]] ; then
    MailObject=$( echo "[MONITORING] $HOSTNAME : ${OkMsg} " )
  elif [[ "${ReturnCode}" = "2" ]] ; then
    MailObject=$( echo -e "[MONITORING] $HOSTNAME : ${NonCriticalMsg} " )
  elif [[ "${ReturnCode}" = "3" ]] ; then
    MailObject=$( echo -e "[MONITORING] $HOSTNAME : ${CriticalMsg} " )
  fi
}
 
# Print domain name before domain information
PrintDomainStart() {
  Domain="${1}"
  DomainStart="\n~~~~~~~~~~~ ${Domain} ~~~~~~~~~~~\n"
  echo -e "${DomainStart}" >> ${TmpFile}
}
 
# Print a "new line" character at the end of a domain field
PrintDomainEnd() {
  DomainStart="\n"
  echo -e "${DomainStart}"
}
 
# Print an "[Ok]" message with the component name
PrintOk() {
  # Usage: $0 called with the "system_name" as $1, its "status" as $2 and the "Logs" flag as $3
  Component="${1}"
  Status="${2}"
  Logs="${3}"
  if [[ "${Logs}" = "1" ]] ; then tab="-50" ; else tab="-25"; fi # If $0 is used to print a Log_Chk() result
                                                                #+ then the "Logs" flag is active and the formatting is different
  printf  -- "- %"${tab}"s --------------> [%s]\n" "[${Component:0:${LENGHT}}]" "$Status" >> ${TmpFile}
}
 
# Print the component name and infos : This is used for example if a component does not exists
PrintInfos() {
  # Usage: $0 called with the "system_name" as $1, its "status" as $2 and the "Logs" flag as $3
  Component="${1}"
  Status="${2}"
  Logs="${3}"
  if [[ "${Logs}" = "1" ]] ; then tab="-50" ; else tab="-25"; fi
  printf  -- "- %"${tab}"s --------------> [%s]\n" "[${Component:0:${LENGHT}}]" "$Status" >> ${TmpFile}
}
 
# Print a "[Non-Critical]" message with the component name
PrintWarning() {
  # Usage: $0 called with the "system_name" as $1, its "status" as $2 and the "Logs" flag as $3
  Component="${1}"
  Status="${2}"
  Logs="${3}"
  if [[ "${Logs}" = "1" ]] ; then tab="-50" ; else tab="-25"; fi
  printf  -- "- %"${tab}"s --------------> [%s]\n" "[${Component:0:${LENGHT}}]" "$Status" >> ${TmpFile}
}
 
# Print a "[Critical]" message with the component name
PrintFailure() {
  # Usage: $0 called with the "system_name" as $1, its "status" as $2 and the "Logs" flag as $3
  Component="${1}"
  Status="${2}"
  Logs="${3}"
  if [[ "${Logs}" = "1" ]] ; then tab="-50" ; else tab="-25"; fi
  printf  -- "- %"${tab}"s --------------> [%s] <----------\n" "[${Component:0:${LENGHT}}]" "$Status" >> ${TmpFile}
}
 
# Print some information about the tested machine
SystemInfo() {
  DOMAIN="INFORMATION"
  PrintDomainStart ${DOMAIN}
 
  # Product Name + Serial Number :
  for level2 in chassis ; do
    for level3 in info ; do
      while IFS=":" read Description data ; do
        PrintInfos "${Description// }" "${data# }"
        if [[ "${Description}" =~ "Chassis.*Model" ]] ; then
        echo "${data# }"
        fi
      done <<<"$(omreport ${level2} ${level3} |grep -E "((^Chassis Model)|(Service Tag))")"
    done
  done
 
  # OS version :
  for level2 in system ; do
    for level3 in operatingsystem ; do
      while IFS=":" read Description data ; do
        PrintInfos "${Description// }" "${data# }"
      done <<<"$(omreport ${level2} ${level3} |grep -E "^[^H].*[[:blank:]]:.*")"
    done
  done
}
 
# Function to check "system" components (see omreport -? for more info about what are "system" components)
System_Chk() {
  DOMAIN="SYSTEM"
  PrintDomainStart ${DOMAIN}
  # overall health status retrieving
  while IFS=": " read Status Name ; do
    if [[ "${Status}" =~ 'Ok' ]] ; then
      PrintOk "${Name}" "${Status}"
    elif [[ "${Status}" =~ 'Non-Critical' ]] ; then
      PrintWarning "${Name}" "${Status}" && RETCODE="${NonCritical}" 2>/dev/null
    elif [[ "${Status}" =~ 'Critical' ]] ; then
      PrintFailure "${Name}" "${Status}" && declare -r RETCODE="${Critical}"
    else
    # This might be used when a device does not exist (such as batteries for PERC H200 controller), this print out an info but does NOT set the error code
    PrintInfos "${level3}_${count}" "${bin1} ${Level3_Status}"
    fi
  done <<<"$(omreport system |grep -E "^(Ok|Critical|Non-Critical)")"
  PrintDomainEnd
  return $RETCODE
}
 
# Function to check "chassis" components (see omreport -? for more info about what are "chassis" components)
Chassis_Chk() {
  DOMAIN="CHASSIS"
  PrintDomainStart ${DOMAIN}
 
  # launch the command that retrieve the chassis components status and append it to the EMAIL temp file
  while IFS=": " read Status Name ; do
    if [[ "${Status}" =~ 'Ok' ]] ; then
      PrintOk "${Name}" "${Status}"
    elif [[ "${Status}" =~ 'Non-Critical' ]] ; then
      PrintWarning "${Name}" "${Status}" && RETCODE="${NonCritical}" 2>/dev/null
    elif [[ "${Status}" =~ 'Critical' ]] ; then
      PrintFailure "${Name}" "${Status}" && declare -r RETCODE="${Critical}"
    else
    PrintInfos "${level3}_${count}" "${bin1} ${Level3_Status }"
    fi
  done <<EOF
            $(omreport chassis |grep -E '^(Ok|Critical|Non-Critical)')
EOF
 
  PrintDomainEnd
  return $RETCODE
}
 
# Function to check "storage" components (see omreport -? for more info about what are "storage" components)
Storage_Chk() {
  DOMAIN="STORAGE"
  PrintDomainStart ${DOMAIN}
 
  # globalinfo => there is NO diagnosys with that s**t
  # cachecade => there is NO such device for our system (R710 & PE2950)
  # connector => This is for the level4 commands..
 
# ControllerIDs is a list which contains each controller IDs
  ControllerIDs=(
                  $(while read line; do
                      read bin ContrID <<<"$(echo $line)"; echo "${ContrID#: }"
                    done <<<"$(omreport storage controller |grep -E "^ID[[:space:]]+:[[:space:]]+[[:digit:]]{0,2}$")")
                )
 
  # Check status for each level_3 components
  for level3 in controller vdisk enclosure battery ; do
    count=0
    while IFS=": " read bin1 Level3_Status ; do  # $bin1: Status (the word) & $Level3_Status: the actual status (Critical, Ok etc)
      if [[ "${level3}" = "controller" ]] && [[ "${bin1} ${Level3_Status}" =~ '^No controllers found$' ]] ; then  # if the tested level_3 command is "controller" AND if it is equal to "^No controllers found$" then there must be no other devices.
        PrintInfos "${level3}_${count}" "${bin1} ${Level3_Status}" && break 2
      fi
        if [[ "${Level3_Status}" =~ 'Ok' ]] ; then
          PrintOk "${level3}_${count}" "${Level3_Status}"
        elif [[ "${Level3_Status}" =~ 'Non-Critical' ]] ; then
          PrintWarning "${level3}_${count}" "${Level3_Status}" && RETCODE="${NonCritical}" 2>/dev/null
        elif [[ "${Level3_Status}" =~ 'Critical' ]] ; then
          PrintFailure "${level3}_${count}" "${Level3_Status}" && declare -r RETCODE="${Critical}"
        elif [[ "${bin1} ${Level3_Status}" =~ '^No.*found$' ]] ; then
          PrintInfos "${level3}_${count}" "${bin1} ${Level3_Status}"
        else
          PrintInfos "${level3}_${count}" "No such device"
        fi
      ((count++))
    done <<<"$(omreport storage ${level3} |grep -E "(Status[[:space:]]+:[[:space:]]+(Critical|Ok|Non-Critical))|(^No.*found$)")"
  done
 
  # Check status for each level_4 components
  for level4_cmd in pdisk connector ; do
    for Cont_IDs in "${ControllerIDs[@]}" ; do
      count="0"
      while IFS=": " read bin1 Level4_Status ; do
        if [[ "${Level4_Status}" =~ 'Ok' ]] ; then
          PrintOk "${level4_cmd}_${count}" "${Level4_Status}"
        elif [[ "${Level4_Status}" =~ 'Non-Critical' ]] ; then
          PrintWarning "${level4_cmd}_${count}" "${Level4_Status}" && RETCODE="${NonCritical}" 2>/dev/null
        elif [[ "${Level4_Status}" =~ 'Critical' ]] ; then
          PrintFailure "${level4_cmd}_${count}" "${Level4_Status}" && declare -r RETCODE="${Critical}"
        elif [[ "${bin1} ${Level4_Status}" =~ '^No.*found$' ]] ; then
          PrintInfos "${level4_cmd}_${count}" "${bin1} ${Level4_Status}"
    else
          PrintInfos "${level4}_${count}" "${bin1} ${Level4_Status// }"
    fi
        ((count++))
      done <<<"$(omreport storage ${level4_cmd} 'controller='"${Cont_IDs}" |grep -E "(Status[[:space:]]+:[[:space:]]+(Critical|Ok|Non-Critical))|(^No.*found$)")"
    done
  done
  PrintDomainEnd
  return $RETCODE
}
 
# This checks logs contents
Log_Chk() {
  # Usage: $0 called with the "log name" as $@ (as a list)
  #+ Note :only the "esmlog" is checked by this function, as it the only relevant log for hardware components status
  if [[ "${ChassisModel}" =~ 'R710' ]] ; then
    DOMAIN="ESMLOG"
    log="esmlog"
  else
    DOMAIN="ALERTLOG"
    log="alertlog"
  fi
  PrintDomainStart ${DOMAIN}
 
  while IFS=";" read Status Data_or_Date Description ; do
    omconfig preferences cdvformat delimiter=semicolon &>/dev/null # Set the "semicolon" as the "cdv"
    if [[ "${Status}" = 'Critical' ]] ; then
      PrintFailure "${Description:0:24}... @ ${Data_or_Date#[[:upper:]][[:alpha:]][[:alpha:]][[:space:]]}" "${Status}" "1" && declare -r RETCODE="${Critical}" 2>/dev/null
    elif [[ "${Status}" = 'Non-Critical' ]] ; then
      PrintWarning "${Description:0:24}... @ ${Data_or_Date#[[:upper:]][[:alpha:]][[:alpha:]][[:space:]]}" "${Status}" "1" && RETCODE="${NonCritical}" 2>/dev/null
    elif [[ "${Status}" = 'Ok' ]] ; then
      PrintOk "${Description:0:24}... @ ${Data_or_Date#[[:upper:]][[:alpha:]][[:alpha:]][[:space:]]}" "${Status}" "1"
    fi
  done <<<"$(omreport system "${log}" -fmt cdv |tail -10 |grep -E "^(Ok|Non-Critical|Critical)" |tac)"
 
  PrintDomainEnd
  return $RETCODE
}
 
# This checks Bios settings
Bios_Chk() {
  # Usage: $0
  DOMAIN="BIOS"
  PrintDomainStart ${DOMAIN}
 
  for level3 in pwrmanagement ; do
    while IFS=":" read Name Status ; do
      if [[ "${Status# }" =~ '^Selected$' ]] ; then
        PrintOk "${Name// }" "${Status# }"                                            # The ${Name// } notation removes every "space" character
      elif [[ "${Status# }" =~ '^Not Selected$' ]] ; then
        PrintFailure "${Name// }" "${Status# }" && declare -r RETCODE="${Critical}"   # The ${Status# } removes one leading "space" char
      else
        PrintInfos "${level3}" "${Name}" "${Status}"
      fi
    done <<<"$(omreport chassis ${level3} "config=profile" |grep -E "^Maximum")"
  done
 
  for attribute in "HyperThreading" "Turbo Mode" ; do
    while IFS=":" read Name Status ; do
      if [[ "${Status# }" =~ '^Enabled$' ]] ; then
        PrintOk "${attribute}" "${Status# }"
      elif [[ "${Status# }" =~ '^Disabled$' ]] ; then
        PrintFailure "${attribute}" "${Status# }" && declare -r RETCODE="${Critical}"
      else
        PrintInfos "${attribute}" "${Name}" "${Status}"
      fi
    done <<<"$(omreport chassis biossetup |grep -E "${attribute}")"
  done
 
  PrintDomainEnd
  return $RETCODE
}
 
# Print (using cat) the informations generated by this script (which are also redirected to ${TmpFile}) on the stdout
Print_on_screen() {
  cat ${TmpFile}
  echo ""
}
 
# Send the content of ${TmpFile} via email (only works at CORYS for now)
SendMail() {
  # generating the Email content
  EMAIL=$(cat ${TmpFile})
 
nc -v ${MAILHOST} 25 1>/dev/null << EOF
ehlo $HOSTNAME
mail from: $HOSTNAME
rcpt to: $ADMIN
data
From: $HOSTNAME
To: $ADMIN
Subject: ${MailObject}
${EMAIL}
.
quit
EOF
 
}
 
#####################################
##### MAIN
#####################################
 
# Cleaning before anything else
rm -f ${TmpDir}/HardChk_EMAIL*
 
# omreport command must be available
if ! ( which omreport && which omconfig ) &>/dev/null ; then
  echo "omreport command not found : please make sure you are on a server and omreport utility is installed, exiting ..." && exit $Fatal_Error
fi
 
# Set the trap command that will call the Cleaning function in any termination cases
trap "Cleaning" SIGHUP SIGINT SIGTERM SIGKILL
 
# generating the Email header
MailHeader
 
#Printing server information
read ChassisModel <<< "$(SystemInfo)"
 
# Start checking all status :
 
## System
System_Chk
RETCODE="${?}"
 
## Chassis
Chassis_Chk
RETCODE="${?}"
 
## Storage
Storage_Chk
RETCODE="${?}"
 
## Bios
Bios_Chk
RETCODE="${?}"
 
## Logs
Log_Chk
RETCODE="${?}"
 
# Generating the Mail object based upon the "worst" RETCODE
AddToMailObject "${RETCODE}"
 
# Generating the Email footer
MailFooter
 
# then we finally send the Email or print outuput on screen if the "--print" (or "-p") flag is active
if [[ "${Local_mode}" = "1" ]] ; then
    Print_on_screen
elif [[ "${Local_mode}" = "0" ]] ; then
    SendMail
else
    exit $Fatal_Error
fi
