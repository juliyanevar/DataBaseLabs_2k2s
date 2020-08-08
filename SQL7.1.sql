use NJV_MyBase

select IDFILM
	from FILM_ACTOR where IDACTOR=1
	group by IDFILM
union
select IDFILM
	from FILM_ACTOR where IDACTOR=2
	group by IDFILM

	select IDFILM
	from FILM_ACTOR where IDACTOR=1
	group by IDFILM
union all
select IDFILM
	from FILM_ACTOR where IDACTOR=2
	group by IDFILM

	select IDFILM
	from FILM_ACTOR where IDACTOR=1
	group by IDFILM
intersect
select IDFILM
	from FILM_ACTOR where IDACTOR=2
	group by IDFILM


	select IDFILM
	from FILM_ACTOR where IDACTOR=1
	group by IDFILM
except
select IDFILM
	from FILM_ACTOR where IDACTOR=2
	group by IDFILM


	select IDFILM,IDACTOR
	from FILM_ACTOR where IDACTOR=1
	group by IDFILM,IDACTOR

		select IDFILM,IDACTOR
	from FILM_ACTOR where IDACTOR=1
	group by rollup (IDFILM,IDACTOR)

		select IDFILM,IDACTOR
	from FILM_ACTOR where IDACTOR=1
	group by cube (IDFILM,IDACTOR)

	alter table films add duration real ;


select min([duration])[min],
	   max([duration])[max],
	   avg([duration])[avg]
from films where [year]='2012'