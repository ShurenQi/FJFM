# Fractional-order Jacobi-Fourier Moments
This repository is an implementation of the method in  
"Robust and Discriminative Image Representation: Fractional-order Jacobi-Fourier Moments", *Pattern Recognition*, under review.  
Code implemented by Shuren Qi ( i@srqi.email ). All rights reserved.  

## Overview

**FJFM: Fractional-order Jacobi-Fourier Moments.** The proposed FJFM is characterized by the generic nature and time-frequency analysis capability. The generic nature means that the FJFM is a generic version of existing Jacobi polynomial-based classical and fractional-order Disc-based Continuous Orthogonal Moments. This property provides a unified mathematical tool for the research of Fractional-order Orthogonal Moments. The time-frequency analysis capability means that the FJFM is able to adjust the zero distributions of the radial kernels by changing value of a fractional parameter. This distinctive characteristic is useful for solving information suppression issues and extracting image local features. In terms of implementation, calculating the polynomial-based moments usually involves some factorial and/or gamma terms, which may leads to numerical instability and high computational costs. For this problem, we introduce a new recursive strategy that allows efficient computing for FJFM.

**MLMF:  Mixed Low-order Moment Feature.** The proposed MLMF is a novel framework to improve both the robustness and discrimination power of image global representation, based on the time-frequency property of FJFM. Our strategy is to combine the low-order moments that with different fractional parameters into a single feature vector, instead of using them as individual features. On the one hand, the fractional parameter is related to the time-domain characteristics of the FJFM basis functions. So combining these moments will make the feature more discriminant. On the other hand, only low-order moments (i.e., low-frequency components) are considered, which guarantees the robustness of the feature. 


