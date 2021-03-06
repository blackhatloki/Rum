/* src/config.h.  Generated by configure.  */
/* src/config.h.in.  Generated from configure.in by autoheader.  */

/* descr */
/* #undef AIX_COMPAT */

/* default shell */
#define DEFAULTSHELL "/bin/bash"

/* system doesnt use /etc/shells */
#define HAS_ETC_SHELLS 1

/* Define to 1 if you have the `basename' function. */
#define HAVE_BASENAME 1

/* we have bstring.h */
/* #undef HAVE_BSTRING_H */

/* Define to 1 if you have the `clearenv' function. */
#define HAVE_CLEARENV 1

/* Define to 1 if you have the <fcntl.h> header file. */
#define HAVE_FCNTL_H 1

/* Define to 1 if you have the `forkpty' function. */
#define HAVE_FORKPTY 1

/* Define to 1 if you have the <getopt.h> header file. */
#define HAVE_GETOPT_H 1

/* Define to 1 if you have the `getopt_long' function. */
#define HAVE_GETOPT_LONG 1

/* Define to 1 if you have the `getusershell' function. */
#define HAVE_GETUSERSHELL 1

/* Define to 1 if you have the <inttypes.h> header file. */
#define HAVE_INTTYPES_H 1

/* Define to 1 if you have the <libgen.h> header file. */
#define HAVE_LIBGEN_H 1

/* Define to 1 if you have the `util' library (-lutil). */
/* #undef HAVE_LIBUTIL */

/* Define to 1 if you have the <memory.h> header file. */
#define HAVE_MEMORY_H 1

/* Define to 1 if you have the <pty.h> header file. */
#define HAVE_PTY_H 1

/* Define to 1 if you have the `sigaction' function. */
#define HAVE_SIGACTION 1

/* Define to 1 if you have the `sigset' function. */
#define HAVE_SIGSET 1

/* Define to 1 if you have the <stdint.h> header file. */
#define HAVE_STDINT_H 1

/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1

/* Define to 1 if you have the <strings.h> header file. */
#define HAVE_STRINGS_H 1

/* Define to 1 if you have the <string.h> header file. */
#define HAVE_STRING_H 1

/* Define to 1 if you have the <stropts.h> header file. */
/* #undef HAVE_STROPTS_H */

/* we have a sys/bsdtypes.h */
/* #undef HAVE_SYS_BSDTYPES_H */

/* Define to 1 if you have the <sys/file.h> header file. */
#define HAVE_SYS_FILE_H 1

/* Define to 1 if you have the <sys/param.h> header file. */
#define HAVE_SYS_PARAM_H 1

/* we have a sys/select.h */
/* #undef HAVE_SYS_SELECT_H */

/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1

/* Define to 1 if you have the <sys/types.h> header file. */
#define HAVE_SYS_TYPES_H 1

/* "Define if your system supports the ttcompat streams module" */
/* #undef HAVE_TTCOMPAT */

/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1

/* descr */
/* #undef HPUX_COMPAT */

/* own replacement for iuclc */
/* #undef IUCLC */

/* enable numbering of syslog lines */
#define LINECNT 1

/* descr */
#define LINUX_COMPAT 

/* directory for session protocols */
#define LOGDIR "/var/log/rootsh"

/* enable logging to a file */
#define LOGTOFILE 1

/* also logging to syslog */
#define LOGTOSYSLOG 1

/* enable logging of username in every line */
#define LOGUSERNAMETOSYSLOG 1

/* lets see what happens */
#define MASTERPTYDEV "/dev/ptmx"

/* maximum size of a logfile in bytes */
#define MAXLOGFILESIZE 0

/* need my own prototype */
#define NEED_GETUSERSHELL_PROTO 0

/* own replacement for o_sync */
/* #undef O_SYNC */

/* Name of package */
#define PACKAGE "rootsh"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT ""

/* Define to the full name of this package. */
#define PACKAGE_NAME "rootsh"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "rootsh 1.5.2"

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "rootsh"

/* Define to the version of this package. */
#define PACKAGE_VERSION "1.5.2"

/* Define as the return type of signal handlers (`int' or `void'). */
#define RETSIGTYPE void

/* descr */
/* #undef SOLARIS_COMPAT */

/* Define to 1 if you have the ANSI C header files. */
#define STDC_HEADERS 1

/* "path to the su command" */
#define SUCMD "/usr/bin/su"

/* Description */
#define SUPPLY_SIGSET_PROTO 

/* syslog facility */
#define SYSLOGFACILITY LOG_LOCAL5

/* syslog facility as string */
#define SYSLOGFACILITYNAME "local5"

/* syslog priority */
#define SYSLOGPRIORITY LOG_NOTICE

/* syslog priority as string */
#define SYSLOGPRIORITYNAME "notice"

/* Version number of package */
#define VERSION "1.5.2"

/* descr */
/* #undef _ALL_SOURCE */
