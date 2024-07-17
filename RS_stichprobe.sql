WITH random_trajectories AS (
  SELECT trajectory_id
  FROM radsim_matching
  ORDER BY RANDOM()
  LIMIT 25000 --stichprobe der trajektorien
)
SELECT rm.ars,
       rm.trajectory_id,
       rm.device_id,
       unnest(rm.edge_ids) as edge_id,
       unnest(rm.edge_directions) as edge_direction,
       unnest(rm.edge_speeds) as edge_speed
FROM radsim_matching AS rm
WHERE rm.trajectory_id IN (SELECT trajectory_id FROM random_trajectories);