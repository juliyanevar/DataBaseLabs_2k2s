use TMPN_UNIVER


-------------------------------------------------
--1

select * from teacher

select teacher,teacher_name,gender,pulpit
		from teacher
		where pulpit='ИСиТ'
		order by Teacher for xml path('Teacher'),
		root('Список_учителей'), elements;

select teacher,teacher_name,gender,pulpit
		from teacher
		where pulpit='ИСиТ'
		order by Teacher for xml raw('Teacher'),
		root('Список_учителей')
-----------------------------------------------------
--2

select*from auditorium
select*from auditorium_type

select auditorium.auditorium_name[Auditorium_name],auditorium_type.auditorium_typename[Auditorium_typename],auditorium.auditorium_capacity[Auditorium_capacity]
		from auditorium join auditorium_type
		on auditorium.auditorium_type=auditorium_type.auditorium_type
		where auditorium.auditorium_type='ЛК'
		order by [Auditorium_name] for xml auto,
		root('List_of_auditories'),elements


-------------------------------------------------------
--3


select * from [subject]


declare @h int=0
declare @x varchar(5000)='<?xml version="1.0" encoding="windows-1251" ?>
       <subjects> 
       <subject subject="КГиГ" subject_name="Компьютерная геометрия и графика" pulpit="ИСиТ"/> 
       <subject subject="ООТП" subject_name="Объектно-ориентированные технологии программирования" pulpit="ИСиТ"/> 
       <subject subject="ВД" subject_name="Веб-дизайн" pulpit="ИСиТ"/> 
       </subjects>';
exec sp_xml_preparedocument @h output, @x;  -- подготовка документа 
insert [subject] select [subject], [subject_name], [pulpit] 
                   from openxml(@h, '/subjects/subject', 0)     
                        with([subject] nvarchar(20), [subject_name] nvarchar(100), [pulpit] nvarchar(10))
--select * from openxml(@h, '/subjects/subject', 0)
--with([subject] nvarchar(20), [subject_name] nvarchar(100), [pulpit] nvarchar(10))       
exec sp_xml_removedocument @h;              -- удаление документа

select * from SUBJECT

delete from subject where subject='КГиГ'
delete from subject where subject='ООТП'
delete from subject where subject='ВД'

---------------------------------------------------------
--4

insert into STUDENT(IDGROUP, NAME, BDAY, INFO) values(22, 'Невар Ю.В.', '01.05.1999',
                                                          '<студент>
														     <паспорт серия="МС" номер="1234567" дата="01.05.2013" />
															 <телефон>+37529180</телефон>
															 <адрес>
															    <страна>Беларусь</страна>
																<город>Минск</город>
																<улица>Полоцкой</улица>
																<дом>1</дом>
																<квартира>68</квартира>
															 </адрес>
														  </студент>');
select * from STUDENT where NAME = 'Невар Ю.В.';
update STUDENT set INFO = '<студент>
					           <паспорт серия="МС" номер="1234567" дата="01.05.2013" />
						       <телефон>+375291802623</телефон>
							   <адрес>
								  <страна>Беларусь</страна>
								  <город>Минск</город>
								  <улица>Полоцкой</улица>
	         					  <дом>1</дом>
								  <квартира>68</квартира>
								</адрес>
							 </студент>'
where NAME = 'Невар Ю.В.';
select NAME[ФИО], INFO.value('(студент/паспорт/@серия)[1]', 'char(2)')[Серия паспорта],
	INFO.value('(студент/паспорт/@номер)[1]', 'varchar(20)')[Номер паспорта],
	INFO.query('/студент/адрес')[Адрес]
		from  STUDENT
			where NAME = 'Невар Ю.В.';  
		
delete from student where NAME = 'Невар Ю.В.';



------------------------------------------------------------
--5

create xml schema collection Student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
   elementFormDefault="qualified"
   xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xs:element name="студент">
<xs:complexType><xs:sequence>
<xs:element name="паспорт" maxOccurs="1" minOccurs="1">
  <xs:complexType>
    <xs:attribute name="серия" type="xs:string" use="required" />
    <xs:attribute name="номер" type="xs:unsignedInt" use="required"/>
    <xs:attribute name="дата"  use="required">
	<xs:simpleType>  <xs:restriction base ="xs:string">
		<xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
	 </xs:restriction> 	</xs:simpleType>
     </xs:attribute>
  </xs:complexType>
</xs:element>
<xs:element maxOccurs="3" name="телефон" type="xs:unsignedInt"/>
<xs:element name="адрес">   <xs:complexType><xs:sequence>
   <xs:element name="страна" type="xs:string" />
   <xs:element name="город" type="xs:string" />
   <xs:element name="улица" type="xs:string" />
   <xs:element name="дом" type="xs:string" />
   <xs:element name="квартира" type="xs:string" />
</xs:sequence></xs:complexType>  </xs:element>
</xs:sequence></xs:complexType>
</xs:element></xs:schema>';

alter table STUDENT alter column INFO xml(Student)

drop XML SCHEMA COLLECTION Student;


insert into STUDENT(IDGROUP, NAME, BDAY, INFO) values(22, 'Невар Ю.В.', '01.05.1999',
                                                          '<студент>
														     <паспорт серия="МС" номер="1234567" дата="01.05.2013" />
															 <телефон>+111111111</телефон>
															 <адрес>
															    <страна>Беларусь</страна>
																<город>Минск</город>
																<улица>Полоцкой</улица>
																<дом>1</дом>
																<квартира>68</квартира>
															 </адрес>
														  </студент>');

select Name, INFO from STUDENT where NAME='Невар Ю.В.'