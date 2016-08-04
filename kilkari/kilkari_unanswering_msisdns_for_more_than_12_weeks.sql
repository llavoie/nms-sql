select distinct MS_ISDN from subscriptions
where Subscription_ID not in
(select distinct a.Subscription_ID
from subscriber_call_measure a
left join subscriptions b on a.Subscription_ID=b.Subscription_ID
where b.Subscription_Status='ACTIVE' and a.Call_Status='SUCCESS')
and Subscription_Status='ACTIVE'  and Activation_Date<'2016-04-21';
--from motech database. The date is to be changed according to the date when you you run the query. It should be 12 weeks from the present date
