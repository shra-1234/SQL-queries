/*List each country name where the population is larger than that of 'Russia'.

world(name, continent, area, population, gdp)*/

SELECT name 
  FROM world
  WHERE population >
     (SELECT population 
      FROM world
      WHERE name='Russia')

/*Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

Per Capita GDP*/

select name 
  from world
  where continent='Europe' 
  and gdp/population > (select gdp/population 
                        from world 
                        where name='United Kingdom')

/*List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.*/

select name,continent
  from world
  where continent in (select continent 
                    from world 
                    where name in ('Argentina','Australia'))
  order by name

/*Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.*/

select name, population 
  from world 
  where population>(select population 
                    from world 
                    where name='United Kingdom') 
  and population<(select population 
                  from world 
                  where name='Germany')

/*Germany (population roughly 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.

Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.*/

select name,concat(round(((population/(select population 
                                        from world   
                                        where name="Germany"))*100),0),"%")
from world
where continent ="Europe"

/*Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)*/

select name 
  from world 
  where gdp> (select max(gdp) 
              from world 
              where continent="Europe")

/*Find the largest country (by area) in each continent, show the continent, the name and the area:

The above example is known as a correlated or synchronized sub-query.

Using correlated subqueries*/

Select  x.continent, x.name,x.area
From world x
where area in (select max(area) 
                from world 
                group by continent) 

/*List each continent and the name of the country that comes first alphabetically.*/

select continent, name 
  from world x 
  where name <= All (select y.name 
                     from world y 
                     where y.continent=x.continent)

/*Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.*/

SELECT name, continent, population 
FROM world x 
WHERE 25000000 > ALL(SELECT population 
                     FROM world y 
                     WHERE y.continent = x.continent 
                     )

/*Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents.*/

select x.name, x.continent
from world x
where x.population >all(select population*3 
                    from world y  
                     where y.continent=x.continent
                      and y.name<>x.name)
