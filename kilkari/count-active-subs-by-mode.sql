SELECT origin, COUNT(*) FROM motech_data_services.nms_subscriptions
WHERE status="ACTIVE"
GROUP BY origin;