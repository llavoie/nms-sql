## MA completions by hour -- change the date manually ##

SELECT HOUR(creationDate), count(*) 
FROM nms_ma_completion_records 
WHERE creationDate > '2016-02-02' 
GROUP BY HOUR(creationDate);