Site,Floor,Row ,Cabinet,Type,Chassis ,Cluster,Hostgroup,RU,Hostname,Slot,Type Hardware,Model Name,Serial Number,Commission date,Description,Status
create database HPC_Inventorydb; 
CREATE TABLE IF NOT EXISTS HPCTable (
     hpcID INT UNSIGNED NOT NULL AUTO_INCREMENT,
     site    VARCHAR(20)  NOT NULL DEFAULT '',    
     floor   INT UNSIGNED  NOT NULL DEFAULT 1,
     row     VARCHAR(10)   NOT NULL DEFAULT '',
     cabinet VARCHAR(10)   NOT NULL DEFAULT '',
     type    VARCHAR(10)   NOT NULL DEFAULT '',
     chassis VARCHAR(10)   NOT NULL DEFAULT '',
     cluster VARCHAR(10)   NOT NULL DEFAULT '',
     hostgroup  VARCHAR(30)   NOT NULL DEFAULT '',
     RU   VARCHAR(20)   NOT NULL DEFAULT '',
     hostname  VARCHAR(20)   NOT NULL DEFAULT '',
     slot     VARCHAR(10)   NOT NULL DEFAULT '',
     hardware_type   VARCHAR(20)   NOT NULL DEFAULT '',
     model_name VARCHAR(20)   NOT NULL DEFAULT '',
     serial_number   VARCHAR(20)   NOT NULL DEFAULT '',
     commission_date  VARCHAR(20)   NOT NULL DEFAULT '',
     desciptiond      VARCHAR(20)   NOT NULL DEFAULT '',
     status     VARCHAR(1)    NOT NULL DEFAULT '',
     PRIMARY KEY hpcID)
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
