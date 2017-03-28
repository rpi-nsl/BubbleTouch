function object = addPlan(object,times,velocities)

if size(times,2) > size(times,1)
    times = times';
end

if size(velocities,2) ~= 3 && size(velocities,2) ~= 6
    error('velocities size is not nx3 (just linear) or nx6 (linear and angular)');
end

if size(velocities,2) == 3
    velocities = [velocities, zeros(size(velocities))];
end

if size(times,2) ~= 1
    error('time is not a 1D vector');
end

if size(times,1) ~= size(velocities,1)
    error('the number of times and velocities are not equal')
end

object.plan = [times, velocities];

end