use NJV_MyBase;


select distinct FILMS.NAME,ACTOR.NAME,FILM_ACTOR.IDACTOR
	from FILMS,ACTOR,FILM_ACTOR
	where FILM_ACTOR.IDACTOR=ACTOR.IDACTOR
		and 
		FILMS.IDFILM in (select top(1) IDFILM from films
								where IDGENRE=12
								order by [NAME])


select distinct FILMS.NAME,ACTOR.NAME,FILM_ACTOR.IDACTOR
	from FILMS,ACTOR,FILM_ACTOR
	where FILM_ACTOR.IDACTOR=ACTOR.IDACTOR
		and 
		FILMS.IDFILM in (select IDFILM from films
								where IDGENRE=12)


select GENRE from GENRE
	where not exists (select * from FILMS
							where films.IDGENRE=genre.IDGENRE)

select top 1
	(select count(idactor) from film_actor
			where IDFILM=1),
	(select count(idactor) from film_actor
			where IDFILM=2),
	(select count(idactor) from film_actor
			where IDFILM=3),
	(select count(idactor) from film_actor
			where IDFILM=4)
	from FILM_ACTOR



