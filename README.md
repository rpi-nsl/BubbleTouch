# BubbleTouch: A Quasi-Static Tactile Skin Simulator

## Introduction
<pre>
The tool is designed to generate noiseless tactile signals.
A 3D object is approximated as a union of spheres, as shown: 
<img src="https://github.com/rpi-nsl/BubbleTouch/blob/master/docs/drill.jpg" width="400">
The resolution of the object model can be adjusted as desired.

Skin elements, taxels, are modeled as sping-damper systems, with a sphere contact model. 
A sensor array is a set of identical taxels. The array will deform the object is pushed onto it:
<img src="https://github.com/rpi-nsl/BubbleTouch/blob/master/docs/array.jpg" width="550">

The simulator produces signals in taxel deformations, which can be converted to forces. 
</pre>

## Citation
If our simulator is found useful in your work, please consider citing:
<pre>
@article{hollis2018bubbletouch,  
  title={BubbleTouch: A Quasi-Static Tactile Skin Simulator},  
  author={Hollis, Brayden and Patterson, Stacy and Cui, Jinda and Trinkle, Jeff},  
  journal={arXiv preprint arXiv:1809.09153},  
  year={2018}  
}  
</pre>

## Installation
1. Download the repository.
2. Add all associated folders to MATLAB path. 
3. "read_ply.m" function from MATLAB graph toolbox is required: http://www.mathworks.com/matlabcentral/fileexchange/5355-toolbox-graph/content/toolbox_graph/read_ply.m


## Usage
