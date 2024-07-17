WITH ranked_trajectories AS (
  SELECT
    ars,
    trajectory_id,
    ROW_NUMBER() OVER (PARTITION BY ars ORDER BY RANDOM()) AS row_num
  FROM radsim_matching
),
random_trajectories AS (
  SELECT ars, trajectory_id
  FROM ranked_trajectories
  WHERE row_num <= 1000  -- Stichprobengröße
)
SELECT
  rm.ars,
  rm.trajectory_id,
  rm.device_id,
  unnest(rm.edge_ids) as edge_id,
  unnest(rm.edge_directions) as edge_direction,
  unnest(rm.edge_speeds) as edge_speed
FROM radsim_matching AS rm
JOIN random_trajectories rt ON rm.ars = rt.ars AND rm.trajectory_id = rt.trajectory_id;