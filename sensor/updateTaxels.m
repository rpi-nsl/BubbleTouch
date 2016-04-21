function [sensor,object] = updateTaxels(sensor,object)
% Currently this function will update taxel values if the passed object
% increases the sensor value (further pushes on the taxel - it goes lower).
% This is under the assumption that the taxels are reset to their maximum
% values and then this function is called for each object.
update = true;

while update
    %% convert object into sensor frame
    % first convert it into world frame
    objCenters = object.orientation*(object.shape(:,1:3))'+kron(object.position,ones(1,size(object.shape,1)));
    % then convert it into sensor frame
    objCentersinSFrame = sensor.orientation'*(objCenters-kron(sensor.position,ones(1,size(object.shape,1))));
    % cancatenate the radius to make spheres again
    objSpheres = [objCentersinSFrame',object.shape(:,4)];

    %% find all the object's spheres that are in the column of each taxel (might be in contact)
    % find the distance from object's spheres to the taxel columns (essentially
    % flatten spheres to the plane)
    D = pdist2(sensor.taxels(:,1:2),objSpheres(:,1:2)) - kron(objSpheres(:,4)',ones(size(sensor.taxels,1),1)) - sensor.RADIUS;
    % find all taxels with at least one sphere in its column.
    taxelInd = find(min(D,[],2) < 0);

    %% update taxel positions
    update = false;
    taxels_heights = sensor.taxels(:,3);
    taxelsContact = sensor.taxelsContact;
    for i = 1:length(taxelInd)
        j = taxelInd(i);
        o = find(D(j,:) < 0);
        % for every taxel with a sphere in the column, calculate the minimum 
        % height the taxel needs to be to be in contact with an object sphere.
        [zhat,o_ind] = min(objSpheres(o,3) - ((objSpheres(o,4)+sensor.RADIUS).^2 ...
                      - (sensor.taxels(j,1)-objSpheres(o,1)).^2 ...
                      - (sensor.taxels(j,2)-objSpheres(o,2)).^2 ).^(.5));
        if zhat < sensor.MINZ
            update = true;
            update_dist = [0;0;sensor.MINZ - zhat];
            object.position = object.position+object.orientation'*sensor.orientation*update_dist;
            %should set this sensor to min value, reposition the object to
            %enforce this, and then recheck all other sensor positions (should
            %also make this a micro step so rotation occurs more correctly).
            %Should also maintain a list of staterated taxels, so in force
            %computation, can split the normal force evenly amongst these
            %taxels, where the normal force is however amount needed to balance
            %in this direction.  This will be trickier when having curved
            %sensors
            warning('SENSOR OUT OF RANGE');
            break;
        end
        % only updates if this taxel needs to be further pressed
        if zhat < sensor.taxels(j,3)
            taxels_heights(j) = zhat;
            taxelsContact(j,:) = [object.id, o(o_ind)];
        end    
    end
    if ~update
        sensor.taxels(:,3) = taxels_heights;
        sensor.taxelsContact = taxelsContact;
    end
end
end

