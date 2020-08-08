USE [TMPN_UNIVER]
GO
/****** Object:  StoredProcedure [dbo].[PSUBJECT]    Script Date: 22.04.2020 23:25:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[PSUBJECT] @p varchar(20)=null,@c int output
as
begin
	declare @k int=(select count(*) from SUBJECT);
	select * from [SUBJECT] where PULPIT=@p;
	set @c=@@rowcount;
	print 'Параметры: @p = '+@p+', @c = '+cast(@c as varchar(3));
	return @k;
end;