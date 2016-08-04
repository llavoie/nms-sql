select *,
case when A.Subscriber_Pack_ID=1
	then (72*7-datediff(A.Activation_Date,A.Lmp))
	else (48*7-datediff(A.Activation_Date,A.Date_Of_Birth))
end as days_supposed_to_be_in_system ,
CASE WHEN A.fulldate is NULL
	THEN datediff('2016-06-29',A.Activation_Date)
	ELSE datediff('2016-06-29',A.fulldate)
END as days_since_last_success
from (select subs.MS_ISDN,ss.Name,v.village_name,ss.Subscriber_ID,subs.Activation_Date,
sd.State_Name as state_name,dd.district_name as district_name,max(dt.FullDate) as fulldate,subs.Subscriber_Pack_ID,
ss.Lmp,ss.Date_Of_Birth,scm.Subscription_Start_Date,b.healthblock_name,sf.healthsubfacility_name
from subscriber_call_measure as scm 
left join subscriptions as subs on scm.Subscription_ID=subs.Subscription_ID and subs.Subscription_Status='ACTIVE'
left join subscribers as ss on ss.Subscriber_ID=subs.Subscriber_ID
left join date_dimension as dt on scm.End_Date_ID=dt.ID 
left join state_dimension as sd on sd.State_ID=ss.State_ID
left join district_dimension as dd on dd.Id=ss.District_ID 
left join village_dimension as v on v.Id=ss.Village_ID
left join healthblock_dimension b on b.Id=ss.HBlock_ID
left join healthsubfacility_dimension sf on sf.Id=ss.HSub_Facility_ID
where scm.Call_Status='SUCCESS' and scm.Call_Source='OBD'
group by ss.Subscriber_ID,subs.MS_ISDN) A

--days since last successful call(reporting database)
