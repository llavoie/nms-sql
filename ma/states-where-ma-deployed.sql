## States where MA is deployed ##

SELECT * FROM motech_data_services.nms_deployed_services as dep 
left join nms_states as st
on dep.state_id_OID = st.id
where service = 'MOBILE_ACADEMY';
