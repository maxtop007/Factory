USE master;

-- Drop database
IF DB_ID('FACTORY') IS NOT NULL DROP DATABASE FACTORY;

-- If database could not be created due to open connections, abort
IF @@ERROR = 3702 
   RAISERROR('Database cannot be dropped because there are still open connections.', 127, 127) WITH NOWAIT, LOG;

-- Create database
CREATE DATABASE FACTORY;
GO

USE FACTORY;
GO
