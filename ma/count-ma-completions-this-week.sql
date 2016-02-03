SELECT COUNT(*) FROM motech_data_services.nms_ma_completion_records
WHERE creationDate >= DATE_SUB(CURDATE(), INTERVAL 7 DAY);