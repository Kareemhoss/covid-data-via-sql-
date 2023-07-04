select * from [dbo].[coviddeaths]
where [continent] is not null;
-- each country with total tests

 select [location],sum([total_tests]) test
 from [dbo].[covidvaccinations]
 group by [location]
 order by test desc;

 -- looking at total cases vs total deathes
 -- shows likelihood of dying if you contract covid in your country 
 select [location],[date],[total_cases],[total_deaths],[new_cases],([total_deaths]/[total_cases])*100 total
 from[dbo].[coviddeaths]
 where  ([total_deaths]/[total_cases]) is not null and [location] like '%egypt%'
 order by date asc ;

 --looking at total cases vs population
 -- shows what percentage of population got covid

  select [location],[date],[total_cases],[ poopulation],([total_cases]/[ poopulation])*100 total
 from[dbo].[coviddeaths]
 where  ([total_deaths]/[total_cases]) is not null and [location] like '%states%' and  [location]not like '%virgin islands%' and [continent] is not null
 order by 1,2 ;

 -- highst infaction rate vs population
 select[location] ,[ poopulation],max([total_cases]) highst_infiction_count,max(([total_cases]/[ poopulation]))*100 total
 from [dbo].[coviddeaths]
 group by [location],[ poopulation]
 order by total desc
 ;

 -- showing the country of highest death count
 select [location],max([total_deaths]) total_deaths
 from [dbo].[coviddeaths]
 where [continent] is not null
 group by [location]
 order by total_deaths desc;

 --by contenent
  select continent,max([total_deaths]) total_deaths
 from [dbo].[coviddeaths]
 where [continent] is not null
 group by continent
 order by total_deaths desc;

 --global numbers

select date, sum([new_cases])as total_newcases,sum([new_deaths])as total_newdeaths--,sum([new_deaths])/sum([new_cases])*100 death_perc
from [dbo].[coviddeaths]
where continent is not null
group by date
order by 1,2 desc;

 -- covid vaccination taple

 select*from [dbo].[coviddeaths] dea join [dbo].[covidvaccinations] vac
 on dea.location = vac.location and dea.date = vac.date;
 
 
  -- looking at total pop vs vacc
 select dea.continent,dea.location,dea.date,[total_vaccinations],[ poopulation]
 from [dbo].[coviddeaths] dea join [dbo].[covidvaccinations] vac
 on dea.location = vac.location and dea.date = vac.date
 where [total_vaccinations] is not null
 order by 1,2,3;

 select dea.continent,dea.location,dea.date,sum([total_vaccinations]) total_vac,sum([ poopulation]) total_popu
 from [dbo].[coviddeaths] dea join [dbo].[covidvaccinations] vac
 on dea.location = vac.location and dea.date = vac.date
 where [total_vaccinations] is not null
 group by dea.continent,dea.location,dea.date
 order by continent desc;

 --looking at total pop vs new vacc

  select dea.continent,dea.location,dea.date,[new_vaccinations],[ poopulation]
 from [dbo].[coviddeaths] dea join [dbo].[covidvaccinations] vac
 on dea.location = vac.location and dea.date = vac.date
 where [total_vaccinations] is not null
 order by 2,3 asc;

  select dea.continent,dea.location,sum([new_vaccinations]) total_vac,sum([ poopulation]) total_popu
 from [dbo].[coviddeaths] dea join [dbo].[covidvaccinations] vac
 on dea.location = vac.location and dea.date = vac.date
 where [total_vaccinations] is not null
 group by dea.continent,dea.location
 order by continent desc;

 -- using partition by 
  select dea.continent,dea.location,dea.date,[ poopulation],
  sum([new_vaccinations]) over (partition by dea.[location] order by dea.location,dea.date) rollingpeoplevac
 from [dbo].[coviddeaths] dea join [dbo].[covidvaccinations] vac
 on dea.location = vac.location and dea.date = vac.date
 where  dea.[continent] is not null
 
 -- creating view 
 create view test as
   select dea.continent,dea.location,sum([new_vaccinations]) total_vac,sum([ poopulation]) total_popu
 from [dbo].[coviddeaths] dea join [dbo].[covidvaccinations] vac
 on dea.location = vac.location and dea.date = vac.date
 where [total_vaccinations] is not null
 group by dea.continent,dea.location
 --order by continent desc;
  ;
 
 select*from dbo.test;







 
 
 







