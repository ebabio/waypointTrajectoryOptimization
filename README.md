# waypointTrajectoryOptimization

Optimization of the 2-d trajectory for a plane so that the jerk is minimized using a non-holonomic particle model. 
Initial and final state constrains are provided and state inequality constraints are added.

The optimization problem is solved for in terms of a direct trajectory optimization problem. 
Trajectory is first discretized and then optimized using MATLAB code. The optimal control law is obtained at discrete time intervals.

![Optimal trajectory and control](/code/logs/OptimalTrajectory.png)
