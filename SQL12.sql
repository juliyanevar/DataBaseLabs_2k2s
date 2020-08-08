-------------------------------------
--1

set nocount on
	if  exists (select * from  SYS.OBJECTS        -- ������� X ����?
	            where OBJECT_ID= object_id(N'DBO.X') )	            
	drop table X;           
	declare @c int, @flag char = 'c';           -- commit ��� rollback?
	SET IMPLICIT_TRANSACTIONS  ON   -- �����. ����� ������� ����������
	CREATE table X(K int );                         -- ������ ���������� 
		INSERT X values (1),(2),(3);
		set @c = (select count(*) from X);
		print '���������� ����� � ������� X: ' + cast( @c as varchar(2));
		if @flag = 'c'  commit;                   -- ���������� ����������: �������� 
	          else   rollback;                                 -- ���������� ����������: �����  
      SET IMPLICIT_TRANSACTIONS  OFF   -- ������. ����� ������� ����������
	
	if  exists (select * from  SYS.OBJECTS       -- ������� X ����?
	            where OBJECT_ID= object_id(N'DBO.X') )
	print '������� X ����';  
      else print '������� X ���'


	 set nocount on
	if  exists (select * from  SYS.OBJECTS        -- ������� X ����?
	            where OBJECT_ID= object_id(N'DBO.X1') )	            
	drop table X1;           
	declare @c int, @flag char = 'r';           -- commit ��� rollback?
	SET IMPLICIT_TRANSACTIONS  ON   -- �����. ����� ������� ����������
	CREATE table X1(K int );                         -- ������ ���������� 
		INSERT X1 values (1),(2),(3);
		set @c = (select count(*) from X1);
		print '���������� ����� � ������� X1: ' + cast( @c as varchar(2));
		if @flag = 'c'  commit;                   -- ���������� ����������: �������� 
	          else   rollback;                                 -- ���������� ����������: �����  
      SET IMPLICIT_TRANSACTIONS  OFF   -- ������. ����� ������� ����������
	
	if  exists (select * from  SYS.OBJECTS       -- ������� X ����?
	            where OBJECT_ID= object_id(N'DBO.X1') )
	print '������� X1 ����';  
      else print '������� X1 ���'
	

----------------------------------------
--2

	use TMPN_UNIVER

	select * from AUDITORIUM

	begin try
		begin tran
			delete AUDITORIUM where AUDITORIUM='206-1';
			insert into AUDITORIUM values ('235-1','��-�',15,'235-1');
			insert into AUDITORIUM values ('408-2','��',90,'408-2');
			update AUDITORIUM set AUDITORIUM_CAPACITY=AUDITORIUM_CAPACITY+5 where AUDITORIUM_CAPACITY=90;
		commit tran;
	end try
	begin catch
		print '������: '+case
			when error_number()=2627 and patindex('%AUDITORIUM_PK%', error_message())>0
			then '����� ��������� ��� ����������'
			else '����������� ������:'+cast(error_number()as varchar(5))+error_message()
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
			insert into AUDITORIUM values ('206-1','��-�',15,'206-1');
			set @point='p2'; save tran @point;
			insert into AUDITORIUM values ('408-2','��',90,'408-2');
			set @point='p3'; save tran @point;
			update AUDITORIUM set AUDITORIUM_CAPACITY=AUDITORIUM_CAPACITY+5 where AUDITORIUM_CAPACITY=90;
		commit tran;
	end try
	begin catch
		print '������: '+case
			when error_number()=2627 and patindex('%AUDITORIUM_PK%', error_message())>0
			then '����� ��������� ��� ����������'
			else '����������� ������:'+cast(error_number()as varchar(5))+error_message()
			end;
		if @@TRANCOUNT>0 
			begin 
				print '����������� �����: '+@point;
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
	select @@SPID, 'insert auditorium' '���������', * from AUDITORIUM 
	                            where AUDITORIUM = '323-1';
	select @@SPID, 'update PULPIT'  '���������',*from PULPIT   where FACULTY = '��';
	commit; 
	-------------------------- t2 -----------------
	--- B --	
	begin transaction 
	select @@SPID
	insert into AUDITORIUM values ('323-1', '��',90, '323-1'); 
	update PULPIT set FACULTY  =  '��' 
                           where PULPIT = '����' 
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
	rollback;


--------------------------------------------------
--5

select * from pulpit

	-- A ---
          set transaction isolation level READ COMMITTED 
	begin transaction 
	select count(*) from PULPIT 	where FACULTY = '���';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  'update PULPIT'  '���������', count(*)
	                           from PULPIT  where FACULTY = '���';
	commit; 

	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          update PULPIT set FACULTY = '���' 
                                       where FACULTY = '����' 
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
	end '���������', AUDITORIUM_CAPACITY from AUDITORIUM  where AUDITORIUM = '112-2';
	commit; 

	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          insert AUDITORIUM values ('112-2',  '��-�',  15,'112-2');
          commit; 
	-------------------------- t2 --------------------


------------------------------------------
--7


    -- A ---
    set transaction isolation level SERIALIZABLE 
	begin transaction 
	delete AUDITORIUM where AUDITORIUM = '112-1';  
          insert AUDITORIUM values ('112-1',  '��-�',  15,'112-1');
          update AUDITORIUM set AUDITORIUM_CAPACITY = 15 where AUDITORIUM = '112-1';
          select  AUDITORIUM_CAPACITY from AUDITORIUM  where AUDITORIUM = '112-1';
	-------------------------- t1 -----------------
	select  AUDITORIUM_CAPACITY from AUDITORIUM  where AUDITORIUM = '112-1';
	-------------------------- t2 ------------------ 
	commit; 	

	--- B ---	
	begin transaction 	  
	delete AUDITORIUM where AUDITORIUM_CAPACITY = 15;  
          insert AUDITORIUM values ('112-1',  '��-�',  15,'112-1');
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
		insert AUDITORIUM_TYPE values ('��-�',  '������������ �����');
			begin tran
				update AUDITORIUM set AUDITORIUM_CAPACITY=15 where AUDITORIUM_TYPE='��-�';
				commit;
				if @@trancount>0 rollback;
			select
				(select count(*) from AUDITORIUM where AUDITORIUM_TYPE='��-�') 'AUDITORIUM',
				(select count(*) from AUDITORIUM_TYPE where AUDITORIUM_TYPE='��-�') 'AUDITORIUM_TYPE';