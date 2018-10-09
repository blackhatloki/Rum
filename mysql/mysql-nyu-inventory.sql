create database ServerDB; 
CREATE TABLE IF NOT EXISTS ServerTable (
     serverID INT UNSIGNED NOT NULL AUTO_INCREMENT,
     siteCode CHAR()       NOT NULL DEFAULT '',    
     countryCode CHAR(3)   NOT NULL DEFAULT '',
     regionCode  CHAR(3)   NOT NULL DEFAULT '',
     datacenter  VARCHAR(30)   NOT NULL DEFAULT '',
     floor       INT UNSIGNED  NOT NULL DEFAULT 1,
     cage        VARCHAR(10)   NOT NULL DEFAULT '',
     cabinet     VARCHAR(10)   NOT NULL DEFAULT '',
	 rackunit    VARCHAR(10)   NOT NULL DEFAULT '',
	 serverName  VARCHAR(30)   NOT NULL DEFAULT '',
	 serverOS    VARCHAR(20)   NOT NULL DEFAULT '',
	 serverENV   VARCHAR(3)    NOT NULL DEFAULT '',    
	 serverRelease  VARCHAR(20)   NOT NULL DEFAULT '',
	 serverHardware VARCHAR(20)   NOT NULL DEFAULT '',
	 serverMgmt     VARCHAR(20)   NOT NULL DEFAULT '',
	 serverSerial   VARCHAR(20)   NOT NULL DEFAULT '',
	 serverAssettag VARCHAR(20)   NOT NULL DEFAULT '',
	 serverVendor   VARCHAR(20)   NOT NULL DEFAULT '',
	 serverMemory   VARCHAR(20)   NOT NULL DEFAULT '',
	 serverCPU      VARCHAR(20)   NOT NULL DEFAULT '',
	 serverSAN      VARCHAR(1)    NOT NULL DEFAULT '',
	 serverNAS      VARCHAR(1)    NOT NULL DEFAULT '',
	 serverBackup   VARCHAR(1)    NOT NULL DEFAULT '',  
	 supportgroup   VARCHAR(20)   NOT NULL DEFAULT '',
	 businessunit   VARCHAR(20)   NOT NULL DEFAULT '',
	 serviceDate    VARCHAR(20)   NOT NULL DEFAULT '',
	 decomDate VARCHAR(20)   NOT NULL DEFAULT '',
     PRIMARY KEY (serverID)
     );
	 
create database HPCDB; 
CREATE TABLE IF NOT EXISTS HPCTable (
     HPCID INT UNSIGNED NOT NULL AUTO_INCREMENT,
     siteCode CHAR()       NOT NULL DEFAULT '',    
     countryCode CHAR(3)   NOT NULL DEFAULT '',
     regionCode  CHAR(3)   NOT NULL DEFAULT '',
     datacenter  VARCHAR(30)   NOT NULL DEFAULT '',
     floor       INT UNSIGNED  NOT NULL DEFAULT 1,
	 cage        VARCHAR(10)   NOT NULL DEFAULT '',
	 cabinet     VARCHAR(10)   NOT NULL DEFAULT '',
	 rackunit    VARCHAR(10)   NOT NULL DEFAULT '',
	 serverName  VARCHAR(30)   NOT NULL DEFAULT '',
	 serverOS    VARCHAR(20)   NOT NULL DEFAULT '',
	 serverENV   VARCHAR(3)    NOT NULL DEFAULT '',    
	 serverRelease  VARCHAR(20)   NOT NULL DEFAULT '',
	 serverHardware VARCHAR(20)   NOT NULL DEFAULT '',
	 clustername    VARCHAR(30)   NOT NULL DEFAULT '',
	 serverMgmt     VARCHAR(20)   NOT NULL DEFAULT '',
	 serverSerial   VARCHAR(20)   NOT NULL DEFAULT '',
	 serverAssettag VARCHAR(20)   NOT NULL DEFAULT '',
	 serverVendor   VARCHAR(20)   NOT NULL DEFAULT '',
	 serverMemory   VARCHAR(20)   NOT NULL DEFAULT '',
	 serverCPU      VARCHAR(20)   NOT NULL DEFAULT '',
	 serverBackup   VARCHAR(1)    NOT NULL DEFAULT '',  
	 nagios         VARCHAR(20)   NOT NULL DEFAULT '',
	 ganglia        VARCHAR(20)   NOT NULL DEFAULT '',
	 businessunit   VARCHAR(20)   NOT NULL DEFAULT '',
	 serviceDate    VARCHAR(20)   NOT NULL DEFAULT '',
	 decomDate VARCHAR(20)   NOT NULL DEFAULT '',
     PRIMARY KEY (HPCID)
     );
	 
create database DellDB; 
CREATE TABLE IF NOT EXISTS DellTable (
     DellID INT UNSIGNED NOT NULL AUTO_INCREMENT,
     siteCode CHAR()       NOT NULL DEFAULT '',    
	 serverSerial   VARCHAR(20)   NOT NULL DEFAULT '',
	 serverVendor   VARCHAR(20)   NOT NULL DEFAULT '',
	 producttype    VARCHAR(20)   NOT NULL DEFAULT '',
	 serviceDate    VARCHAR(20)   NOT NULL DEFAULT '',
	 decomDate VARCHAR(20)   NOT NULL DEFAULT '',
     PRIMARY KEY (DellID)
     );
	 
	 
	 
create database NetworkHPCDB; 
CREATE TABLE IF NOT EXISTS NetworkTable (
     networkHPCCID INT UNSIGNED NOT NULL AUTO_INCREMENT,
     siteCode       CHAR(3)       NOT NULL DEFAULT '',    
     countryCode    CHAR(3)   NOT NULL DEFAULT '',
     regionCode     CHAR(3)   NOT NULL DEFAULT '',
     datacenter     VARCHAR(30)   NOT NULL DEFAULT '',
     switchshow   VARCHAR(30)   NOT NULL DEFAULT '',
     linkspeed      VARCHAR(20)   NOT NULL DEFAULT '',
     serviceDate    VARCHAR(20)   NOT NULL DEFAULT '',
     decomDate VARCHAR(20)   NOT NULL DEFAULT '',
     PRIMARY KEY (networkHPCID)
     ); 	 
