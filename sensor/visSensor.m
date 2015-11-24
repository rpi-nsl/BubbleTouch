figure;
maxz = max(max(data));
for i=1:1500
    
    shot = data(i,:);
    n = sqrt(length(shot));
    subplot(1,2,1), pcolor(reshape(shot,n,n)), axis equal
    subplot(1,2,2), mesh(reshape(shot,n,n))
    xlim([1,n]);
    ylim([1,n]);
    zlim([0,maxz]);
    
    drawnow
end