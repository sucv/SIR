# Introduction
This is a matlab implementation for the paper *A Context-aware Locality Measure for Inlier Pool
Enrichment in Stepwise Image Registration*. This method is named SIR. It is currently under review by IEEE transactions on image processing.

SIR is currently for 2-D image registration. It has yet been generalized to a point-set registration method. It can be taken as a progressively generalized version of the GLPM [1] with an improved continuous dissimilarity measure.

>[1] Ma, Jiayi, Junjun Jiang, Huabing Zhou, Ji Zhao, and Xiaojie Guo. "Guided locality preserving feature matching for remote sensing image registration." IEEE transactions on geoscience and remote sensing 56, no. 8 (2018): 4435-4447.

The inputs of SIR include:
- 'fs' and 'ft', the 4-by-N and 4-by-M  features extracted by the loosest SIFT threshold, where the 1st and 2nd rows are the spatial coordinates, and the 3rd and 4th rows are the scales and orientations.
- 'ds' and 'dt', the 128-by-N and 128-by-M  feature descriptor corresponding to fs and ft, respectively, where each column is the 128 dimensional SIFT feature descriptor for a feature point.
- 'tau_0', the loosest NNDR threshold used to establish the universal feature set.
- 'tau', the NNDR threshold to establish the putative inlier set for the SIR.

The outputs of SIR include:
- 'index', the final inlier set I*.
- 'I_x' and 'I_y', the inliers from the two feature sets.
- 'SxHat', the transformed moving points.

# Environment
To run the demo, the VLFEAT toolbox is required. It can be downloaded from [this page](http://www.vlfeat.org/download.html "VLFEAT"). Please follow [this instruction](http://www.vlfeat.org/install-matlab.html "VLFEAT setup") for either one-time or permanent setup.