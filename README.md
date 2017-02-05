# Description
Motion tubes is a Dense Trajectory based based tracking mechanism I propose, to identify and track candidate moving areas
separately. This enables independent modeling of the activities in each moving area. In order to capture motion patterns, we use histogram oriented optic flows (HOOF) inside motion tubes. Then we apply a bag-of-words (BoW) method on the generated
features to capture the distributional properties of micro actions, such as body movements, and create high level, discriminative motion features.

This enables the system to track each actor or object independently, and model the motion patterns individually over a long time period. This allows the system to model actions occurring in a video in micro level, and use these learned dynamics
at a high level afterwards.

For extracting motion features we create motion tubes across frames, where we track each moving area across the frames using "action boxes". Action boxes are square regions, which exhibit significant motion in each frame. We choose candidate areas by first creating dense trajectories for each frame, and then clustering trajectory points preceded by a significant amount of pre-processing. This process is explained in sub-section. These action boxes create motion tubes by getting linking across the frames. Then we calculate HOOF features within these motion tubes and apply a bag-of-features method on these to create a motion descriptor for each video segment.

The full methodology can be found in our paper "Combined Static and Motion Features for Deep-Networks Based Activity Recognition in
Videos", which is submitted to TCSVT (IEEE special issue). 

#Running the code

First, the video files must be processed using dense trajectories code, https://lear.inrialpes.fr/people/wang/dense_trajectories, and the output xml files containing the dense traectory information should be saved. The format ouf the output file should be as follows. 
<POINTS>
<POINT>frame_number x_coordinate y_cordinate</POINT>
..
..
..
<POINTS>


Then you can directly use this XML file as a input file in generating the matrices in MATLAB. Run the main method after setting the path parameters correctly. This will save output matrices as files in local drive.
