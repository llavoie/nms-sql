SELECT st.name, 
       Count(*) 
FROM   nms_states AS st 
       join (SELECT IF(ss.subscriptionpack_id_oid = 1, m.state_id_oid, 
                    c.state_id_oid) 
                    AS 
                    state_id_OID 
             FROM   nms_subscriptions AS ss 
                    join nms_subscribers AS s 
                      ON s.id = ss.subscriber_id_oid 
                    left join nms_mcts_mothers AS m 
                           ON m.id = s.mother_id_oid 
                    left join nms_mcts_children AS c 
                           ON c.id = s.child_id_oid 
             WHERE  ss.status = 'ACTIVE' 
                    AND ss.origin = 'MCTS_IMPORT') AS sub 
         ON sub.state_id_oid = st.id 
GROUP  BY st.id; 
