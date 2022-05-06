#!/bin/bash   
      
echo Start Executing SQL commands
sqlplus / as sysdba @/home/oracle/generate_dbschema.sql;

