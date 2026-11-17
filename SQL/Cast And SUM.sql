SELECT
  SUM(successes) AS successes,                          -- 5
  SUM(attempts) AS attempts,                            -- 12
  CAST(SUM(successes) / SUM(attempts) AS DECIMAL) AS cast_after_division,   -- 0  
  ROUND(100.0 * SUM(successes) / SUM(attempts), 2) AS success_pct           -- 41.67
FROM batches;
