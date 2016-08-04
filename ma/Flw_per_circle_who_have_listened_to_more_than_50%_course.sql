select cdm.circle_name,
count(distinct cdm.calling_msisdn) 
from ma_call_detail_measure as cdm
join ma_course_status as ma on cdm.flw_id=ma.flw_id
join front_line_worker as flw on cdm.flw_id=flw.id
join ma_call_content_measure as m on cdm.id=m.call_detail_id
join ma_dimension as md on m.content_id=md.id
where flw.flw_status='ACTIVE' and (cdm.circle_name='BI' or cdm.circle_name='MP' or cdm.circle_name='UW' or cdm.circle_name='RA')
and md.content_name in (
select X.content_name from 
(select content_name from (select cast(trim(replace(replace(replace(content_name, 'Chapter',''),'_Lesson',''),'0','')) as unsigned) as L, content_name  from ma_dimension where content_name like '%Lesson%') V
where V.L > 51
union
select content_name from 
(select cast(trim(replace(replace(replace(content_name, 'Chapter',''),'_Question',''),'0','')) as unsigned) as Q,content_name from ma_dimension where content_name like '%Question%') U
where U.Q > 50) X  
)
group by cdm.circle_name
--Flws per circle who have listened to more than 50% of the course (reporting database)
