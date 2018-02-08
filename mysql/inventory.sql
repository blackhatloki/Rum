create database HPC_InventoryDB;
CREATE TABLE IF NOT EXISTS HPC_inventory_Table (
     productID INT UNSIGNED NOT NULL AUTO_INCREMENT,
     country VARCHAR(20)  NOT NULL DEFAULT '',
     site    VARCHAR(20)  NOT NULL DEFAULT '',
     floor   INT UNSIGNED  NOT NULL DEFAULT 1,
     room    VARCHAR(10)   NOT NULL DEFAULT '',
     rowname VARCHAR(10)   NOT NULL DEFAULT '',
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
     PRIMARY KEY productID)
     );
country
site
room
row
cabinet
type
chassis model
cluster
monitoring hostgroup
u-position
hostname
slot
model type
model name
serial number
commission date
description
status
PI
school
dept

