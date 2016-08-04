select a.callingNumber,
case when sub.subscriptionPack_id_OID=1
	then b.beneficiaryId
	else c.beneficiaryId
end as beneficiaryId,
case when sub.subscriptionPack_id_OID=1
	then b.name
	else c.name
end as name,s.name as state,d.name as district,hb.name as healthblock,hs.name as subfacility,v.name as village
from nms_subscribers a
join nms_subscriptions sub on a.id=sub.subscriber_id_OID
left join nms_mcts_mothers b on a.mother_id_OID=b.id
left join nms_mcts_children c on a.child_id_OID=c.id
left join nms_states s on b.state_id_OID=s.id
left join nms_districts d on b.district_id_OID=d.id
left join nms_health_blocks hb on b.healthBlock_id_OID=hb.id
left join nms_health_sub_facilities hs on b.healthSubFacility_id_OID=hs.id
left join nms_villages v on b.village_id_OID=v.id
where sub.subscriptionId in (select subscriptionId from nms_deactivation_subscription_audit_records where modificationDate like '2016-07-14%')
--To be run on motech database with modification date being the date when deactivation was done.
