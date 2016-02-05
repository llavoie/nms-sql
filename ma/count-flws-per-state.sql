### FLWs per state ###

SELECT 
	st.name as stateName, COUNT(DISTINCT flw.id) as activeFLWs
FROM
	MTRAINING_MODULE_BOOKMARK as bk
LEFT JOIN nms_front_line_workers as flw
	on bk.externalId = flw.contactNumber
LEFT JOIN nms_states as st
    on st.id = flw.state_id_OID
LEFT JOIN MTRAINING_MODULE_ACTIVITYRECORD as ar
	on bk.externalId = ar.externalId
WHERE 
	bk.progress IS NOT NULL AND ar.state = 'STARTED'
GROUP BY 
	flw.state_id_OID
ORDER BY 
	stateName;