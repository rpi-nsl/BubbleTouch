function setWorldDamper(damper)
%setWorldDamper sets the world.damper variable, which is the fraction of
%previous velocity that is used for the next time step

global world;

world.damper = damper;

end