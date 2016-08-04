SELECT cds.callingNumber,cds.callId,cds.callDisconnectReason,cds.callStartTime,cds.callEndTime,cds.creationDate,cds.circle,cd.contentFileName,cd.subscriptionPack
FROM nms_inbox_call_details cds
left join nms_inbox_call_data cd on cds.id=cd.content_id_OWN 
where cds.creationDate between '2016-05-01' and '2016-06-01'
order by cds.creationDate

--inbox call details (motech database)
