use TMPN_UNIVER
-----------------------------------
--1


go
create procedure PSUBJECT
as
begin
	declare @k int=(select count(*) from SUBJECT);
	select * from [SUBJECT];
	return @k;
end;
	

declare @k int =0;
exec @k=PSUBJECT;
print '���-�� ��������� = '+cast(@k as varchar(3));


-----------------------------------
--2

--ALTER procedure [dbo].[PSUBJECT] @p varchar(20)=null,@c int output
--as
--begin
--	declare @k int=(select count(*) from SUBJECT);
--	select * from [SUBJECT] where PULPIT=@p;
--	set @c=@@rowcount;
--	print '���������: @p = '+@p+', @c = '+cast(@c as varchar(3));
--	return @k;
--end;

declare @k int=0, @r int =0, @p varchar(20);
exec @k=PSUBJECT @p='����', @c=@r output;
print '���-�� ��������� ����� = '+cast(@k as varchar(3));
print '���-�� ��������� �� ������� = '+cast(@r  as varchar(3));
	


--------------------------------
--3

--ALTER procedure [dbo].[PSUBJECT] @p varchar(20)=null
--as
--begin
--	declare @k int=(select count(*) from SUBJECT);
--	select * from [SUBJECT] where PULPIT=@p;
--end;

create table #subject
(  [SUBJECT]  char(10) primary key, 
   SUBJECT_NAME varchar(100) unique,
   PULPIT  char(20)  
 );


 insert #subject exec PSUBJECT @p='����';
 insert #subject exec PSUBJECT @p='��';

 select * from #subject


------------------------------------
--4


create procedure PAUDITORIUM_INSERT @a char(20), @n varchar(50),
										@c int=0, @t char(10)
as declare @rc int = 1;
begin try
	insert into AUDITORIUM(AUDITORIUM,AUDITORIUM_NAME,AUDITORIUM_CAPACITY,AUDITORIUM_TYPE)
					values(@a, @n, @c, @t)
	return @rc;
end try
begin catch
	print '����� ����� : '+cast(error_number() as varchar(6));
	print '��������� : '+error_message();
	print '������� : '+cast(error_severity() as varchar(6));
	print '����� : '+cast(error_state() as varchar(8));
	print '����� ������ : '+cast(error_line() as varchar(8));
	if error_procedure() is not null
	print '��� ��������� : '+error_procedure();
	return -1;
end catch;


select * from AUDITORIUM

declare @rc int;
exec @rc=PAUDITORIUM_INSERT @a='200-3�',@n='200-3�',@c=90,@t='��';
print '��� ������ : '+ cast(@rc as varchar(3));



---------------------------------------------
--5

create procedure SUBJECT_REPORT @p char(10)
as
declare @rc int=0;
begin try
	declare @tv char(20), @t char(300)='';
	declare subj cursor for 
		select [SUBJECT] from [SUBJECT] where PULPIT=@p;
	if not exists (select [SUBJECT] from [SUBJECT] where PULPIT=@p)
		raiserror('������',11,1);
	else
		open subj;
		fetch subj into @tv;
		print '����������';
		while @@FETCH_STATUS=0
			begin
				set @t=rtrim(@tv)+','+@t;
				set @rc=@rc+1;
				fetch subj into @tv;
			end;
		print @t;
		close subj;
		DEALLOCATE subj;
	return @rc;
end try
begin catch
	print '������ � ����������'
	if error_procedure() is not null
		print '��� ��������� : '+error_procedure();
	return @rc;
end catch;

select * from SUBJECT

declare @rc int;
exec @rc = SUBJECT_REPORT @p='����'
print '���������� ��������� = '+cast(@rc as varchar(3));


---------------------------------------------
--6
select*from AUDITORIUM
select*from AUDITORIUM_TYPE


create procedure PAUDITORIUM_INSERTX @a char(20), @n varchar(50),
							@c int=0, @t char(10), @tn varchar(50)
as  declare @rc int=1;                            
begin try 
    set transaction isolation level SERIALIZABLE;          
    begin tran
    insert into AUDITORIUM_TYPE(AUDITORIUM_TYPE,AUDITORIUM_TYPENAME)
					values(@t, @tn)
    exec @rc=PAUDITORIUM_INSERT @a, @n, @c, @t;  
    commit tran; 
    return @rc;           
end try
begin catch 
    print '����� ������  : ' + cast(error_number() as varchar(6));
    print '���������     : ' + error_message();
    print '�������       : ' + cast(error_severity()  as varchar(6));
    print '�����         : ' + cast(error_state()   as varchar(8));
    print '����� ������  : ' + cast(error_line()  as varchar(8));
    if error_procedure() is not  null   
                     print '��� ��������� : ' + error_procedure();
     if @@trancount > 0 rollback tran ; 
     return -1;	  
end catch;


declare @rc int;  
exec @rc = PAUDITORIUM_INSERTX @a='112-3',@n='112-3',@c=15,@t='��-�1',@tn='������������ �����1'
print '��� ������ = ' + cast(@rc as varchar(3));  

