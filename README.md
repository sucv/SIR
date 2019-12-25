# Introduction
This is a matlab implementation for the SIR algorithm: 
- **Su Zhang, Wanjing Zhao, Xuying Hao, Yang Yang, and Cuntai Guan, "A Context-aware Locality Measure for Inlier Pool Enrichment in Stepwise Image Registration", IEEE Transactions on Image Processing, Dec 2019, DOI: 10.1109/TIP.2019.2961480**

SIR is currently for 2-D feature matching and image registration. It has yet been generalized to a point-set registration method. It can be taken as a progressively generalized version of the GLPM [1] algorithm with an improved continuous dissimilarity measure.

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

# Experiment
A simple demo is provided for a direct showcase. Experiments on feature matching, image registration and image retrieval are also provided, together with the dataset. Please make sure the whole project is added to the Matlab working directory.

# Dataset
- FM_ACF.mat: feature matching on [Affine Covariant Features (ACF)](http://www.robots.ox.ac.uk/~vgg/research/affine/index.html "ACF").
    - A feature pair is considered as an inlier pair if the overlap score [3] is no less than 0.5.
- FM_RS.mat and IReg_RS.mat: feature matching and image registration on remote sensing data from [1] and [2], respectively.
- IReg_FIRE.mat: image registration on [FIRE](https://www.ics.forth.gr/cvrl/fire/ "FIRE").
- IRet_holiday.mat and IRet_ukbench.mat: image retrieval on [Holiday](http://lear.inrialpes.fr/people/jegou/data.php "Holiday") and [UKBench](https://archive.org/details/ukbench "UKBench"), respectively.
    - The features are extracted using vl_sift() function with NNDR threshold 1.0.

# Reference
>[1] Ma, Jiayi, Junjun Jiang, Huabing Zhou, Ji Zhao, and Xiaojie Guo. "Guided locality preserving feature matching for remote sensing image registration." IEEE transactions on geoscience and remote sensing 56, no. 8 (2018): 4435-4447.
>[2] Yang, Kun, Anning Pan, Yang Yang, Su Zhang, Sim Ong, and Haolin Tang. "Remote sensing image registration using multiple image features." Remote Sensing 9, no. 6 (2017): 581.
>[3] Mikolajczyk, Krystian, Tinne Tuytelaars, Cordelia Schmid, Andrew Zisserman, Jiri Matas, Frederik Schaffalitzky, Timor Kadir, and Luc Van Gool. "A comparison of affine region detectors." International journal of computer vision 65, no. 1-2 (2005): 43-72.
