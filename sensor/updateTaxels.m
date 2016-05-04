function [sensor,object,objectMoved] = updateTaxels(sensor,object)
% Currently this function will update taxel values if the passed object
% increases the sensor value (further pushes on the taxel - it goes lower).
% This is under the assumption that the taxels are reset to their maximum
% values and then this function is called for each object.
update = true;

%slack for resolution of matlab
epsilon = 10^-10;

while update
    %% convert object into sensor frame
    % first convert it into world frame
    objCenters = object.orientation*(object.shape(:,1:3))'+kron(object.position,ones(1,size(object.shape,1)));
    % then convert it into sensor frame
    objCentersinSFrame = sensor.orientation'*(objCenters-kron(sensor.position,ones(1,size(object.shape,1))));
    % cancatenate the radius to make spheres again
    objSpheres = [objCentersinSFrame',object.shape(:,4)];
    
    %% prelimary enforcement of taxels min value
    %note, due to sphere contact, this will likely need to happen again,
    %but doing it here has the benefit of only redoing it for the taxels in
    %contact with the objects 'peak'.
    objLowestPoint = min(objSpheres(:,3)-objSpheres(:,4));
    % if object beyond sensor capabilities, move object
    % TODO: moving object may not be best solution (and may not work when
    % multiple sensors.
    if objLowestPoint < sensor.MINZ
        if isfield(object,'static') && object.static
            warning(['object is set to static, so it technically should not be moved\n'...
                'this needs to be fixed in the future (sensor should move)']);
            %also need to somehow make sure object can be moved due to
            %other sensors/update other previously computed sensors
        end
        objectMoved = true;
        update_dist = [0;0;sensor.MINZ - objLowestPoint];
        %update objectSpheres position:
        objSpheres(:,3) = objSpheres(:,3) + update_dist(3);
        %update actual object position
        %note: position is in world corredinates, so updates should be made
        %in world cordinates
        object.position = object.position+sensor.orientation*update_dist;
        %should set this sensor to min value, reposition the object to
        %enforce this, and then recheck all other sensor positions (should
        %also make this a micro step so rotation occurs more correctly).
        %Should also maintain a list of staterated taxels, so in force
        %computation, can split the normal force evenly amongst these
        %taxels, where the normal force is however amount needed to balance
        %in this direction.  This will be trickier when having curved
        %sensors
    end

    %% find all the object's spheres that are in the column of each taxel (might be in contact)
    % keep only spheres that could be in contact with sensor pad
    objSpheres = objSpheres(objSpheres(:,3)-objSpheres(:,4) < sensor.MAXZ+sensor.RADIUS,:);
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
        if zhat < sensor.MINZ - epsilon 
            objectMoved = true;
            update = true;
            update_dist = [0;0;sensor.MINZ - zhat];
            %position is in world corredinates, so updates should be made
            %in world cordinates
            object.position = object.position+sensor.orientation*update_dist;
            %should set this sensor to min value, reposition the object to
            %enforce this, and then recheck all other sensor positions (should
            %also make this a micro step so rotation occurs more correctly).
            %Should also maintain a list of staterated taxels, so in force
            %computation, can split the normal force evenly amongst these
            %taxels, where the normal force is however amount needed to balance
            %in this direction.  This will be trickier when having curved
            %sensors
            warning('SENSOR OUT OF RANGE');
            if isfield(object,'static') && object.static
                warning('object is set to static, so it technically should not be moved')
                warning('this needs to be fixed in the future (sensor should move)');
                %also need to somehow make sure object can be moved due to
                %other sensors/update other previously computed sensors
            end
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

