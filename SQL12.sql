-------------------------------------
--1

set nocount on
	if  exists (select * from  SYS.OBJECTS        -- таблица X есть?
	            where OBJECT_ID= object_id(N'DBO.X') )	            
	drop table X;           
	declare @c int, @flag char = 'c';           -- commit или rollback?
	SET IMPLICIT_TRANSACTIONS  ON   -- включ. режим неявной транзакции
	CREATE table X(K int );                         -- начало транзакции 
		INSERT X values (1),(2),(3);
		set @c = (select count(*) from X);
		print 'количество строк в таблице X: ' + cast( @c as varchar(2));
		if @flag = 'c'  commit;                   -- завершение транзакции: фиксация 
	          else   rollback;                                 -- завершение транзакции: откат  
      SET IMPLICIT_TRANSACTIONS  OFF   -- выключ. режим неявной транзакции
	
	if  exists (select * from  SYS.OBJECTS       -- таблица X есть?
	            where OBJECT_ID= object_id(N'DBO.X') )
	print 'таблица X есть';  
      else print 'таблицы X нет'


	 set nocount on
	if  exists (select * from  SYS.OBJECTS        -- таблица X есть?
	            where OBJECT_ID= object_id(N'DBO.X1') )	            
	drop table X1;           
	declare @c int, @flag char = 'r';           -- commit или rollback?
	SET IMPLICIT_TRANSACTIONS  ON   -- включ. режим неявной транзакции
	CREATE table X1(K int );                         -- начало транзакции 
		INSERT X1 values (1),(2),(3);
		set @c = (select count(*) from X1);
		print 'количество строк в таблице X1: ' + cast( @c as varchar(2));
		if @flag = 'c'  commit;                   -- завершение транзакции: фиксация 
	          else   rollback;                                 -- завершение транзакции: откат  
      SET IMPLICIT_TRANSACTIONS  OFF   -- выключ. режим неявной транзакции
	
	if  exists (select * from  SYS.OBJECTS       -- таблица X есть?
	            where OBJECT_ID= object_id(N'DBO.X1') )
	print 'таблица X1 есть';  
      else print 'таблицы X1 нет'
	

----------------------------------------
--2

	use TMPN_UNIVER

	select * from AUDITORIUM

	begin try
		begin tran
			delete AUDITORIUM where AUDITORIUM='206-1';
			insert into AUDITORIUM values ('235-1','ЛБ-К',15,'235-1');
			insert into AUDITORIUM values ('408-2','ЛК',90,'408-2');
			update AUDITORIUM set AUDITORIUM_CAPACITY=AUDITORIUM_CAPACITY+5 where AUDITORIUM_CAPACITY=90;
		commit tran;
	end try
	begin catch
		print 'ошибка: '+case
			when error_number()=2627 and patindex('%AUDITORIUM_PK%', error_message())>0
			then 'такая аудитория уже существует'
			else 'неизвестная ошибка:'+cast(error_number()as varchar(5))+error_message()
			end;
		if @@TRANCOUNT>0 rollback tran;
	end catch;

---------------------------------------------
--3

select * from AUDITORIUM

		declare @point varchar(32);
		begin try
		begin tran
			delete AUDITORIUM where AUDITORIUM='206-1';
			set @point='p1'; save tran @point;
			insert into AUDITORIUM values ('206-1','ЛБ-К',15,'206-1');
			set @point='p2'; save tran @point;
			insert into AUDITORIUM values ('408-2','ЛК',90,'408-2');
			set @point='p3'; save tran @point;
			update AUDITORIUM set AUDITORIUM_CAPACITY=AUDITORIUM_CAPACITY+5 where AUDITORIUM_CAPACITY=90;
		commit tran;
	end try
	begin catch
		print 'ошибка: '+case
			when error_number()=2627 and patindex('%AUDITORIUM_PK%', error_message())>0
			then 'такая аудитория уже существует'
			else 'неизвестная ошибка:'+cast(error_number()as varchar(5))+error_message()
			end;
		if @@TRANCOUNT>0 
			begin 
				print 'контрольная точка: '+@point;
				rollback tran @point;
				commit tran;
			end;
	end catch;


------------------------------------
--4

	--A--
	set transaction isolation level READ UNCOMMITTED 
	begin transaction 
	-------------------------- t1 ------------------
	select @@SPID, 'insert auditorium' 'результат', * from AUDITORIUM 
	                            where AUDITORIUM = '323-1';
	select @@SPID, 'update PULPIT'  'результат',*from PULPIT   where FACULTY = 'ИТ';
	commit; 
	-------------------------- t2 -----------------
	--- B --	
	begin transaction 
	select @@SPID
	insert into AUDITORIUM values ('323-1', 'ЛК',90, '323-1'); 
	update PULPIT set FACULTY  =  'ИТ' 
                           where PULPIT = 'ИСиТ' 
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
	rollback;


--------------------------------------------------
--5

select * from pulpit

	-- A ---
          set transaction isolation level READ COMMITTED 
	begin transaction 
	select count(*) from PULPIT 	where FACULTY = 'ЛХФ';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  'update PULPIT'  'результат', count(*)
	                           from PULPIT  where FACULTY = 'ЛХФ';
	commit; 

	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          update PULPIT set FACULTY = 'ЛХФ' 
                                       where FACULTY = 'ХТиТ' 
          commit; 
	-------------------------- t2 --------------------	




---------------------------------------------
--6
select * from AUDITORIUM

	-- A ---
    set transaction isolation level  REPEATABLE READ 
	begin transaction 
	select AUDITORIUM_CAPACITY from AUDITORIUM where AUDITORIUM = '112-2';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  case
          when AUDITORIUM_CAPACITY = 15 then 'insert  AUDITORIUM'  else ' ' 
	end 'результат', AUDITORIUM_CAPACITY from AUDITORIUM  where AUDITORIUM = '112-2';
	commit; 

	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          insert AUDITORIUM values ('112-2',  'ЛБ-К',  15,'112-2');
          commit; 
	-------------------------- t2 --------------------


------------------------------------------
--7


    -- A ---
    set transaction isolation level SERIALIZABLE 
	begin transaction 
	delete AUDITORIUM where AUDITORIUM = '112-1';  
          insert AUDITORIUM values ('112-1',  'ЛБ-К',  15,'112-1');
          update AUDITORIUM set AUDITORIUM_CAPACITY = 15 where AUDITORIUM = '112-1';
          select  AUDITORIUM_CAPACITY from AUDITORIUM  where AUDITORIUM = '112-1';
	-------------------------- t1 -----------------
	select  AUDITORIUM_CAPACITY from AUDITORIUM  where AUDITORIUM = '112-1';
	-------------------------- t2 ------------------ 
	commit; 	

	--- B ---	
	begin transaction 	  
	delete AUDITORIUM where AUDITORIUM_CAPACITY = 15;  
          insert AUDITORIUM values ('112-1',  'ЛБ-К',  15,'112-1');
          update AUDITORIUM set AUDITORIUM_CAPACITY = 15 where AUDITORIUM = '112-1';
          select  AUDITORIUM_CAPACITY from AUDITORIUM  where AUDITORIUM = '112-1';
          -------------------------- t1 --------------------
          commit; 
          select  AUDITORIUM_CAPACITY from AUDITORIUM  where AUDITORIUM = '112-1';
      -------------------------- t2 --------------------


-------------------------------------------
--8
select * from AUDITORIUM_TYPE
select * from AUDITORIUM
---------????????
	begin tran
		insert AUDITORIUM_TYPE values ('ЛБ-К',  'Компьютерный класс');
			begin tran
				update AUDITORIUM set AUDITORIUM_CAPACITY=15 where AUDITORIUM_TYPE='ЛБ-К';
				commit;
				if @@trancount>0 rollback;
			select
				(select count(*) from AUDITORIUM where AUDITORIUM_TYPE='ЛБ-К') 'AUDITORIUM',
				(select count(*) from AUDITORIUM_TYPE where AUDITORIUM_TYPE='ЛБ-К') 'AUDITORIUM_TYPE';