--Create Database
CREATE DATABASE VK_module_2
ON PRIMARY
	(NAME='VK_module_2',
	FILENAME='c:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\VK_module_2.mdf',
	SIZE=4MB,
	MAXSIZE=10MB,
	FILEGROWTH=1MB)
LOG ON 
	(NAME='VK_module_2_log',
	FILENAME='c:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\VK_module_2_log.ldf',
	SIZE=1MB,
	MAXSIZE=10MB,
	FILEGROWTH=1MB);
GO

USE VK_module_2
GO