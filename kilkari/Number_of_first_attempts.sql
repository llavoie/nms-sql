select ss.Subscriber_ID,st.State_Name, d.district_name, s.MS_ISDN,count(*) as number_of_first_attempts,s.Activation_Date,s.Subscriber_Pack_ID
from subscriber_call_measure scm
left join subscriptions s on s.Subscription_ID=scm.Subscription_ID and s.Subscription_Status='ACTIVE'--taken only active subscribers
left join subscribers as ss on ss.Subscriber_ID=s.Subscriber_ID
left join state_dimension as st on st.State_ID=ss.State_ID
left join date_dimension as dd on dd.ID=scm.End_Date_ID 
left join district_dimension as d on d.Id=ss.District_ID
where scm.Call_Source='OBD' and scm.Attempt_Number=1
--took all 1st attempts calls for call source obd with subscriber id and subscriber_pack_id. Date is not necessary here
group by ss.Subscriber_ID,s.MS_ISDN
order by st.State_Name, d.district_name

--The above table gives total number of first attempts made to the subscriber (reporting database)
