select sub.Subscriber_ID, sub.MS_ISDN,count(*) as number_of_calls_unsuccessful,
sum(case when scm.Call_Status='NA' then 1 else 0 end) as 'NOT_Answered',
sum(case when scm.Call_Status='ND' then 1 else 0 end) as 'NOT_Delivered',
sum(case when scm.Call_Status='SO' then 1 else 0 end) as 'Switched_Off' --Count of all missed calls with each with count of each in the next three rows
from subscriber_call_measure scm
left join subscriptions sub on sub.Subscription_ID=scm.Subscription_ID
where scm.Call_Status<>'SUCCESS' and scm.Call_Source='OBD'
group by sub.MS_ISDN
-- status-wise call unsuccessful count for outbound calls (reporting database)
