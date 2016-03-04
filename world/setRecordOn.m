function setRecordOn(fileName)

global world

world.record = true;
world.video = VideoWriter(strcat('data/',fileName,'.avi'));

end
