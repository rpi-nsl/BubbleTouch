function object = addPlan(object,times,velocities)

if size(times,2) > size(times,1)
    times = times';
end

if size(velocities,2) ~= 3
    error('velocities size is not nx3');
end

if size(times,2) ~= 1
    error('time is not a 1D vector');
end

if size(times,1) ~= size(velocities,1)
    error('the number of times and velocities are not equal')
end

object.plan = [times, velocities];

end