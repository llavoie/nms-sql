SELECT DATE(creationDate), count(*) FROM motech_data_services.nms_subscriptions
WHERE origin = 'IVR'
GROUP BY DATE(creationDate);
