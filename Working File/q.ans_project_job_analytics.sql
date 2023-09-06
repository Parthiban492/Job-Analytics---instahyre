create database job_analytics;
use job_analytics;


select *  from jobs;
select *  from company;
select *  from details;

#######################################################################################################

#### You need to generate aggregations and that will help you
# create dashboard which should be able to help the end user 
#with following insights:

# Aggregations :-

## 1) Total Job count by Company:-

select c.name as company_name, count(*)as job_count
from jobs j
join company c on j.company_id =c.company_id
group by c.name
order by job_count desc;


## 2)Job count by Location:-
select location, count(*)as job_count
from jobs
group by location
order by job_count desc;

## 3) Job count by Designation:-

select designation, count(*)as job_count
from jobs
group by designation
order by job_count desc;

## 4) Company-wise Employee count:

select name as company_name, employees_count
from company
order by employees_count desc;

## 5)  Job count by Involvement (Full-time,Part-time etc.)
select involvement, count(*)as job_count
from details
group by involvement;

## 6) Popular Skills Required:
select skills, count(*)as job_count
from details
group by skills
order by job_count desc;

##  7) Job count by Year of Establishment:-
select estab_year, count(*)as job_count
from company
group by estab_year
order by job_count desc;

## 8) HR-wise Job count:-
select hr_name, count(*)as job_count
from details
group by hr_name
order by job_count desc;


###############################################################################################################

## Comparison of number of jobs across different cities for different level 
select designation,location,count(*) as job_count
from jobs
group by designation, location
order by designation, location;


##Generate some insight with respect to number of jobs distribution across various industry. For instance,
## what is the total number of jobs in Software Industry as compared to Marketing
select 
case
when designation like '%software%' then 'Software Industry'
when designation like '%market%' then 'Marketing Industry'
else 'Other Industries'
end as industry,
count(*)as job_count
from jobs
group by industry;


##Generate insights into number of opening with respect to the current employee 
#count - Number of opening in a company with more than 1000 employees in comparison
# to number of openings in a company with 100 employees
select 
SUM(case when c.employees_count = 1000 then 1 else 0 end)as companies_more_than_1000,
SUM(case when c.employees_count < 100 then 1 else 0 end)as companies_100,
SUM(case when c.employees_count = 1000 then j.job_count else 0 end)as openings_in_companies_equal_1000,
SUM(case when c.employees_count < 100 then j.job_count else 0 end)as openings_in_companies_less_than_100
from company c
left join(
select company_id,count(*)as job_count
from jobs
group by company_id
)j on c.company_id=j.company_id;




##Generate any one interesting insight from the data 
select skills, count(*)as skill_count
from details
group by skills
order by skill_count desc
limit 1;




##count the number of jobs across different industry across different locations.
# For instance, how many Frontend Engineer jobs are there in Bangalore as 
#compared to Data Analytics jobs in Bangalore, or how many Data Analytics jobs
# are there in Bangalore as compared to number of Data Scientists job in Gurgaon
# - this needs to be done in SQL but presented in the above created Excel dashboard
select
j.designation,
j.location,
count(*)as job_count
from
jobs j
group by
j.designation,
j.location;
    
    