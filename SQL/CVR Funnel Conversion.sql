WITH user_calculation AS (
  SELECT user_id,
         MAX(CASE WHEN event_type = 'view'    THEN 1 ELSE 0 END) AS did_view,
         MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS did_purchase
  FROM events
  GROUP BY user_id
)
SELECT ROUND(100.0 * SUM(did_purchase) / COUNT(*), 1) AS cvr_pct
FROM user_calculation
WHERE did_view = 1;



| user_id | event_type | event_ts    |
| ------- | ---------- | ----------- |
| U1      | view       | 11-01 10:00 |
| U1      | cart       | 11-01 10:05 |
| U1      | purchase   | 11-01 10:10 |
| U2      | view       | 11-01 11:00 |
| U2      | cart       | 11-01 11:05 |
| U3      | view       | 11-02 09:00 |
| U3      | purchase   | 11-02 09:30 |
| U4      | view       | 11-03 12:00 |
| U5      | view       | 11-03 13:00 |
| U5      | cart       | 11-03 13:10 |
| U5      | purchase   | 11-03 13:20 |
| U6      | cart       | 11-04 10:00 |
| U6      | purchase   | 11-04 10:05 |

  
| user_id | view | cart | purchase |
| ------- | ---- | ---- | -------- |
| U1      | O    | O    | O        |
| U2      | O    | O    | X        |
| U3      | O    | X    | O        |
| U4      | O    | X    | X        |
| U5      | O    | O    | O        |
| U6      | X    | O    | O        |
