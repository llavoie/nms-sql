### New MA users this week ###
use motech_data_services;
SELECT 
	DISTINCT bk.externalId, flw.name, flw.mctsFlwId, flw.status,
    ar.creationDate as startDate
FROM
	MTRAINING_MODULE_BOOKMARK as bk
LEFT JOIN nms_front_line_workers as flw
	on bk.externalId = flw.contactNumber
LEFT JOIN nms_flw_cdrs as cdr
    on cdr.callingNumber = bk.externalId    
LEFT JOIN MTRAINING_MODULE_ACTIVITYRECORD as ar
	on bk.externalId = ar.externalId
WHERE 
	bk.progress IS NOT NULL AND ar.state = 'STARTED' AND 
    ar.creationDate >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
GROUP BY 
	bk.externalId
ORDER BY 
	startDate;