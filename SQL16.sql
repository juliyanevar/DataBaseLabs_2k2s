use TMPN_UNIVER


-------------------------------------------------
--1

select * from teacher

select teacher,teacher_name,gender,pulpit
		from teacher
		where pulpit='����'
		order by Teacher for xml path('Teacher'),
		root('������_��������'), elements;

select teacher,teacher_name,gender,pulpit
		from teacher
		where pulpit='����'
		order by Teacher for xml raw('Teacher'),
		root('������_��������')
-----------------------------------------------------
--2

select*from auditorium
select*from auditorium_type

select auditorium.auditorium_name[Auditorium_name],auditorium_type.auditorium_typename[Auditorium_typename],auditorium.auditorium_capacity[Auditorium_capacity]
		from auditorium join auditorium_type
		on auditorium.auditorium_type=auditorium_type.auditorium_type
		where auditorium.auditorium_type='��'
		order by [Auditorium_name] for xml auto,
		root('List_of_auditories'),elements


-------------------------------------------------------
--3


select * from [subject]


declare @h int=0
declare @x varchar(5000)='<?xml version="1.0" encoding="windows-1251" ?>
       <subjects> 
       <subject subject="����" subject_name="������������ ��������� � �������" pulpit="����"/> 
       <subject subject="����" subject_name="��������-��������������� ���������� ����������������" pulpit="����"/> 
       <subject subject="��" subject_name="���-������" pulpit="����"/> 
       </subjects>';
exec sp_xml_preparedocument @h output, @x;  -- ���������� ��������� 
insert [subject] select [subject], [subject_name], [pulpit] 
                   from openxml(@h, '/subjects/subject', 0)     
                        with([subject] nvarchar(20), [subject_name] nvarchar(100), [pulpit] nvarchar(10))
--select * from openxml(@h, '/subjects/subject', 0)
--with([subject] nvarchar(20), [subject_name] nvarchar(100), [pulpit] nvarchar(10))       
exec sp_xml_removedocument @h;              -- �������� ���������

select * from SUBJECT

delete from subject where subject='����'
delete from subject where subject='����'
delete from subject where subject='��'

---------------------------------------------------------
--4

insert into STUDENT(IDGROUP, NAME, BDAY, INFO) values(22, '����� �.�.', '01.05.1999',
                                                          '<�������>
														     <������� �����="��" �����="1234567" ����="01.05.2013" />
															 <�������>+37529180</�������>
															 <�����>
															    <������>��������</������>
																<�����>�����</�����>
																<�����>��������</�����>
																<���>1</���>
																<��������>68</��������>
															 </�����>
														  </�������>');
select * from STUDENT where NAME = '����� �.�.';
update STUDENT set INFO = '<�������>
					           <������� �����="��" �����="1234567" ����="01.05.2013" />
						       <�������>+375291802623</�������>
							   <�����>
								  <������>��������</������>
								  <�����>�����</�����>
								  <�����>��������</�����>
	         					  <���>1</���>
								  <��������>68</��������>
								</�����>
							 </�������>'
where NAME = '����� �.�.';
select NAME[���], INFO.value('(�������/�������/@�����)[1]', 'char(2)')[����� ��������],
	INFO.value('(�������/�������/@�����)[1]', 'varchar(20)')[����� ��������],
	INFO.query('/�������/�����')[�����]
		from  STUDENT
			where NAME = '����� �.�.';  
		
delete from student where NAME = '����� �.�.';



------------------------------------------------------------
--5

create xml schema collection Student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
   elementFormDefault="qualified"
   xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xs:element name="�������">
<xs:complexType><xs:sequence>
<xs:element name="�������" maxOccurs="1" minOccurs="1">
  <xs:complexType>
    <xs:attribute name="�����" type="xs:string" use="required" />
    <xs:attribute name="�����" type="xs:unsignedInt" use="required"/>
    <xs:attribute name="����"  use="required">
	<xs:simpleType>  <xs:restriction base ="xs:string">
		<xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
	 </xs:restriction> 	</xs:simpleType>
     </xs:attribute>
  </xs:complexType>
</xs:element>
<xs:element maxOccurs="3" name="�������" type="xs:unsignedInt"/>
<xs:element name="�����">   <xs:complexType><xs:sequence>
   <xs:element name="������" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="���" type="xs:string" />
   <xs:element name="��������" type="xs:string" />
</xs:sequence></xs:complexType>  </xs:element>
</xs:sequence></xs:complexType>
</xs:element></xs:schema>';

alter table STUDENT alter column INFO xml(Student)

drop XML SCHEMA COLLECTION Student;


insert into STUDENT(IDGROUP, NAME, BDAY, INFO) values(22, '����� �.�.', '01.05.1999',
                                                          '<�������>
														     <������� �����="��" �����="1234567" ����="01.05.2013" />
															 <�������>+111111111</�������>
															 <�����>
															    <������>��������</������>
																<�����>�����</�����>
																<�����>��������</�����>
																<���>1</���>
																<��������>68</��������>
															 </�����>
														  </�������>');

select Name, INFO from STUDENT where NAME='����� �.�.'