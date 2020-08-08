use master

create database N_UNIVER_TEST on primary
( name = N'N_UNIVER_mdf', filename = N'C:\BD\N_UNIVER_mdf.mdf', 
   size = 5Mb, maxsize=10Mb, filegrowth=1Mb),
( name = N'N_UNIVER_ndf', filename = N'C:\BD\N_UNIVER_ndf.ndf', 
   size = 5Mb, maxsize=10Mb, filegrowth=10%),
filegroup FG1
( name = N'N_UNIVER_fg1_1', filename = N'C:\BD\N_UNIVER_fgq-1.ndf', 
   size = 10Mb, maxsize=15Mb, filegrowth=1Mb),
( name = N'N_UNIVER_fg1_2', filename = N'C:\BD\N_UNIVER_fgq-2.ndf', 
   size = 2Mb, maxsize=5Mb, filegrowth=1Mb),
   filegroup FG2
( name = N'N_UNIVER_fg2_1', filename = N'C:\BD\N_UNIVER_fgq2-1.ndf', 
   size = 5Mb, maxsize=10Mb, filegrowth=1Mb),
( name = N'N_UNIVER_fg2_2', filename = N'C:\BD\N_UNIVER_fgq2-2.ndf', 
   size = 2Mb, maxsize=5Mb, filegrowth=1Mb)
log on
( name = N'N_UNIVER_log', filename=N'C:\BD\N_UNIVER_log.ldf',       
   size=5Mb,  maxsize=UNLIMITED, filegrowth=1Mb)

   drop database N_UNIVER_TEST;