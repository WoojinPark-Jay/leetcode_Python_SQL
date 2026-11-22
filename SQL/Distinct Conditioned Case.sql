WITH per_user AS (
    SELECT user_id,
           MAX(CASE WHEN kind='view' THEN 1 ELSE 0 END) AS viewed,
           MAX(CASE WHEN kind='buy' THEN 1 ELSE 0 END) AS bought
    FROM events
    WHERE user_id IS NOT NULL
    GROUP BY user_id
)
SELECT COUNT(DISTINCT CASE WHEN viewed=1 THEN user_id END) AS viewers,
       COUNT(DISTINCT CASE WHEN viewed=1 AND bought=1
                           THEN user_id END) AS converted,
       ROUND(100.0 * SUM(CASE WHEN viewed=1 AND bought=1 THEN 1 ELSE 0 END)
             / NULLIF(SUM(viewed),0),1) AS cvr_pct
FROM per_user;
