use TMPN_UNIVER

declare @tv char(20), @t char(300)='';
declare subj cursor for select [subject] from [SUBJECT] where pulpit='ИСиТ';
	open subj;
	fetch subj into @tv;
	print 'Дисциплины на кафедре ИСиТ';
	while @@fetch_status=0
		begin 
			set @t=rtrim(@tv)+','+@t;
			fetch subj into @tv;
		end;
	print @t;
close subj;

--------------------------------
--2

DECLARE Subjects CURSOR LOCAL                            
	             for SELECT [SUBJECT] , PULPIT from [SUBJECT];
DECLARE @tv char(20), @pulpit char(15);      
	OPEN Subjects;	  
	fetch  Subjects into @tv, @pulpit; 	
      print '1. '+@tv+@pulpit;   
      go

 DECLARE @tv char(20), @pulpit char(15);     	
	fetch  Subjects into @tv, @pulpit; 	
      print '2. '+@tv+@pulpit;  
  go   


  declare Subjects cursor global 
					for select [SUBJECT], PULPIT from [SUBJECT];
  declare @tv char(20), @pulpit char(15);
	open Subjects;
	fetch Subjects into @tv, @pulpit;
	print '1.'+@tv+@pulpit;
	go
  declare @tv char(20), @pulpit char(15);
	fetch Subjects into @tv, @pulpit;
	print '2.'+@tv+@pulpit;
	close Subjects;
	deallocate Subjects;
	go


-------------------------------------
--3


DECLARE @tid char(10), @tnm char(20);  
	DECLARE Subjects CURSOR LOCAL DYNAMIC                              
		 for SELECT [SUBJECT] , PULPIT from [SUBJECT] where PULPIT = 'ИСиТ';				   
	open Subjects;
	print   'Количество строк : '+cast(@@CURSOR_ROWS as varchar(5)); 
    	UPDATE [SUBJECT] set PULPIT = 'ТЛ' where [SUBJECT] = 'ИГ';
	DELETE [SUBJECT] where [SUBJECT] = 'ИНФ';
	INSERT [SUBJECT] ([SUBJECT],[SUBJECT_NAME],[PULPIT]) 
	                 values ('ООТП','Объектно-ориентированные технологии программирования','ИСиТ'); 
	FETCH  Subjects into @tid, @tnm;     
	while @@fetch_status = 0                                    
      begin 
          print @tid + ' '+ @tnm ;      
          fetch Subjects into @tid, @tnm; 
       end;          
   CLOSE  Subjects;



----------------------------------------------
--4


         DECLARE  @tc int, @rn char(50);  
         DECLARE Primer1 cursor local dynamic SCROLL                               
               for SELECT row_number() over (order by [SUBJECT]) N,
	                           [SUBJECT] FROM [SUBJECT] 
                                        where PULPIT = 'ИСиТ' 
	OPEN Primer1;
	FETCH  Primer1 into  @tc, @rn;                 
	print 'следующая строка        : ' + cast(@tc as varchar(3))+' '+ rtrim(@rn);      
	FETCH  LAST from  Primer1 into @tc, @rn;       
	print 'последняя строка          : ' +  cast(@tc as varchar(3))+' '+ rtrim(@rn);      
	FETCH  FIRST from  Primer1 into @tc, @rn;       
	print 'первая строка          : ' +  cast(@tc as varchar(3))+' '+ rtrim(@rn); 
	FETCH  NEXT from  Primer1 into @tc, @rn;       
	print 'следующая строка за текущей          : ' +  cast(@tc as varchar(3))+' '+ rtrim(@rn); 
	FETCH  PRIOR from  Primer1 into @tc, @rn;       
	print 'предыдущая строка от текущей          : ' +  cast(@tc as varchar(3))+' '+ rtrim(@rn); 
	FETCH  ABSOLUTE 3 from  Primer1 into @tc, @rn;       
	print 'третья строка от начала          : ' +  cast(@tc as varchar(3))+' '+ rtrim(@rn); 
	FETCH  ABSOLUTE -3 from  Primer1 into @tc, @rn;       
	print 'третья строка от конца          : ' +  cast(@tc as varchar(3))+' '+ rtrim(@rn); 
	FETCH  RELATIVE 5 from  Primer1 into @tc, @rn;       
	print 'пятая строка вперёд от текущей          : ' +  cast(@tc as varchar(3))+' '+ rtrim(@rn); 
	FETCH  RELATIVE -5 from  Primer1 into @tc, @rn;       
	print 'пятая строка назад от текущей          : ' +  cast(@tc as varchar(3))+' '+ rtrim(@rn); 
      CLOSE Primer1;



-------------------------------------------------
--5-6

declare @ti int,@tn nvarchar(20), @tc int, @tk int, @ts char(10);
declare Primer2 cursor local dynamic
		for select STUDENT.IDSTUDENT,STUDENT.[NAME], GROUPS.IDGROUP,PROGRESS.NOTE,PROGRESS.[SUBJECT]
							from PROGRESS join STUDENT 
		on progress.IDSTUDENT=STUDENT.IDSTUDENT
		join GROUPS on Student.IDGROUP=GROUPS.IDGROUP
		where PROGRESS.NOTE=4
		for update;
open Primer2;
fetch Primer2 into @ti,@tn, @tc, @tk, @ts;
while @@fetch_status=0
begin
	if (@ti=1005)
		update PROGRESS set NOTE=NOTE+1;
	else
		delete PROGRESS where current of Primer2;
fetch Primer2 into @ti,@tn, @tc, @tk, @ts;
end;
close Primer2;


delete from PROGRESS
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values ('ОАиП', 1000,  '01.10.2013',6),
           ('ОАиП', 1001,  '01.10.2013',8),
           ('ОАиП', 1002,  '01.10.2013',7),
           ('ОАиП', 1003,  '01.10.2013',5),
           ('ОАиП', 1005,  '01.10.2013',4),
		   ('СУБД', 1014,  '01.12.2013',5),
           ('СУБД', 1015,  '01.12.2013',9),
           ('СУБД', 1016,  '01.12.2013',5),
           ('СУБД', 1017,  '01.12.2013',4),
		   ('КГ',   1018,  '06.5.2013',4),
           ('КГ',   1019,  '06.05.2013',7),
           ('КГ',   1020,  '06.05.2013',7),
           ('КГ',   1021,  '06.05.2013',9),
           ('КГ',   1022,  '06.05.2013',5),
           ('КГ',   1023,  '06.05.2013',6);



---------------------------------------------
-- 8 

declare cursorFaculty cursor local static 
	for 
		select Faculty.FACULTY from FACULTY 

declare cursorPulpit cursor local static 
	for 
		select Faculty.FACULTY,PULPIT.PULPIT
	from FACULTY join PULPIT
		on PULPIT.FACULTY=FACULTY.FACULTY
		order by FACULTY.FACULTY

declare cursorSubject cursor local static 
	for
		select [subject],SUBJECT.PULPIT from [SUBJECT] order by PULPIT

declare cursorTeacher cursor local static 
	for
		select count(*),Teacher.PULPIT from [Teacher] group by PULPIT;

declare @tv char(20), @t char(300)='', @clear char(300)='',@faculty varchar(15),
		@pulpit varchar(15),@pulpittmp varchar(15),@teacher varchar(45),
		@temp varchar(45),@fetchst1 int =7,@fetchst2 int,@count int;

	open cursorFaculty;  
    FETCH  cursorFaculty into @faculty; 
	set @fetchst1 = @@fetch_status;
	while @fetchst1 = 0                                   
      begin 
          print 'Faculty '+@faculty;
			open cursorPulpit;
			FETCH  cursorPulpit into @temp,@pulpit;
			set @fetchst2 = @@fetch_status;
				while @fetchst2 = 0                                    
					begin 
						if(@temp = @faculty)
							begin
								print '		Pulpit '+@pulpit; 
								open cursorTeacher;
									fetch cursorTeacher into @count,@pulpittmp;
									while @@fetch_status=0
										begin 
											if (@pulpittmp = @pulpit)
												begin
													print '			Count of teachers : ' + cast(@count as nvarchar(3)); 
												end;
											fetch cursorTeacher into @count,@pulpittmp;
										end;
								close cursorTeacher;
								set @count =0; 
								set @t = @clear;
								open cursorSubject;
									fetch cursorSubject into @tv,@pulpittmp;
									set @count =0;
									while @@fetch_status=0
										begin 
											if (@pulpittmp = @pulpit)
												begin
													set @t=rtrim(@tv)+','+@t;
													set @count =1;
												end
											fetch cursorSubject into @tv,@pulpittmp;
										end;
									if(@count = 0)
										set @t =' not.';
									else
										set @t = SUBSTRING(@t,1,len(@t)-1) +'.';
									print '		    Subjects : '+@t;
								close cursorSubject;
							end;
			 			FETCH  cursorPulpit into @temp,@pulpit;
						set @fetchst2 = @@FETCH_STATUS;
					end;
			FETCH  cursorPulpit into @temp,@pulpit;
			close cursorPulpit;
          FETCH  cursorFaculty into @faculty; 
		  set @fetchst1 = @@FETCH_STATUS
       end;          
	CLOSE  cursorFaculty;