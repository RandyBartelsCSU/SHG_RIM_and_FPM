# SHG_RIM_and_FPM
Data and code for SHG RIM, Fourier Ptychography, and Optical Diffraction Tomography

Data can be accessed here:https://colostate-my.sharepoint.com/:f:/g/personal/gmmurray_colostate_edu/EmT_NZov2DpMiEhWYvIuhFgB3TF-QPhxATSJT7WTmu9K3w?e=ys8Wvw

Start by running the example live scripts for examples of how to manipulate the data and how it is structured. The function "IntensityStack.m" will generate a 3D matrix containing the set of Intensity images as well as a set of vectors describing the incidence angle of the illumination (in spatial frequency units). They will be ordered in the same way respectivly. For field information  the functions "GenerateTransmissionMatrix.m" and "GenerateTransmissionMatrixObjectFrame" will produce a matrix containing the reconstructed fields from the set of holograms. These matrices are structured such that each column contains a field array which has been flattened (all columns stacked on top of one another) into a vector. Each column corresponds to a different incidence angle. "GenerateTransmissionMatrixObjectFrame" will center the spectrum of each incidence angle to the object's coordinates. Run "ReconstructFieldsFromHologramsExample.mlx" to see examples and movies of the reconstructions.

Thank you very much and if you have any questions or trouble with code or data please email me at gmmurray@colostate.edu.
