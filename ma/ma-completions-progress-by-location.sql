### Total Completions/Progress so far ###

SELECT 
	DISTINCT bk.externalId, flw.name, flw.mctsFlwId, flw.status, cr.smsReferenceNumber, 
    dis.code as districtCode, dis.name as districtName, st.code as stateCode, st.name as stateName, cdr.circle as circleName, 
    lan.name as language, ar.creationDate as startDate, cr.creationDate as completionDate
FROM
	MTRAINING_MODULE_BOOKMARK as bk
LEFT JOIN nms_front_line_workers as flw
	on bk.externalId = flw.contactNumber
LEFT JOIN nms_states as st
    on st.id = flw.state_id_OID
LEFT JOIN nms_districts as dis
    on dis.id = flw.district_id_OID
LEFT JOIN nms_languages as lan
    on flw.language_id_OID = lan.id
LEFT JOIN nms_flw_cdrs as cdr
    on cdr.callingNumber = bk.externalId    
LEFT JOIN MTRAINING_MODULE_ACTIVITYRECORD as ar
	on bk.externalId = ar.externalId
LEFT JOIN nms_ma_completion_records as cr
	on bk.externalId = cr.callingNumber
WHERE 
	bk.progress IS NOT NULL AND ar.state = 'STARTED'
GROUP BY 
	bk.externalId
ORDER BY 
	stateName, districtName, circleName, startDate, completionDate;