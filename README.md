This repository provides everything needed to reproduce all 17 figures from:\
Neural Embeddings Rank: Aligning 3D Latent Dynamics with Movements\
**Chenggang Chen**, Zhiyu Yang, and Xiaoqin Wang. NeurIPS 2024

This work has also been accepted by:\
The First Workshop on NeuroAI @ NeurIPS 2024:\
https://neuroai-workshop.github.io  
NeurIPS 2024 Workshop: Self-Supervised Learning (SSL) as an **Oral** presentation\
https://sslneurips2024.github.io/index.html  

NER has received eight reviews.\
All reviews are above borderline acceptance (score 5), with reviewers giving higher scores also reporting higher confidence:\
NeurIPS: Scores: 7, 7, 6; Confidence: 4, 3, 1  
NeuroAI: Scores: 9, 7, 7; Confidence: 5, 4, 3  
SSL:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Scores: 8, 7&nbsp;&nbsp;&nbsp;&nbsp;; Confidence: 2, 4

NER is the first dimensionality reduction method capable of revealing movement-aligned 3D latent dynamics:
![alt text](https://github.com/NeuroscienceAI/NER/blob/main/NER_Figs_pdf/demo_crop_compress.gif)\
Left: Hand velocities of center-out reaching in eight directions (color-coded).
Right: 3D latent dynamics

All network training can be reproduced through the Jupyter Notebooks in the "NER_Figs_ipynb" folder.\
NER modifies CEBRA’s loss function, so if you can run CEBRA (any version), you can run NER.\
To train NER after setting up CEBRA, you have two options:\
1. Replace the original cebra folder (containing data, ..., solver) in your main CEBRA folder with the downloaded "NER_Code_1021" folder.
2. Follow the instructions in "NER_Code_1021" (see NER changes to CEBRA.pdf) to modify the original CEBRA folder.\

The "data" folder contains the smoothed raw data (Gaussian kernel). Since the raw data is in MATLAB format, we also processed it with MATLAB (MATLAB code included).\
The "data_NER" folder contains intermediate results (.npz) after network training, which the Jupyter Notebooks in "NER_Figs_ipynb" use to generate .pdf figures (including demo videos) saved in the "NER_Figs_pdf" folder.

FAQ:

Have you optimized CEBRA’s hyperparameters? No. We fixed the time offset to 1 time bin and temperature to 1. While grid-searching hyperparameters would likely improve both NER and CEBRA performance, we did not perform this step.

What limitations does NER have compared to CEBRA? NER requires continuous labels that can be ranked, such as velocities, positions, or angles. It isn’t suited for discrete classes, as seen in CEBRA’s video decoding (CEBRA Fig. 4 and 5), where the 900 frames are uncorrelated. However, ranking video embeddings (extracted by DINO) is possible, though performance may not exceed CEBRA. Additionally, NER’s execution time is almost twice as long as CEBRA’s.

What types of data work best for NER? Continuous labels like hand or body movements are ideal. Labels must match the neural data length and should be three-dimensional if you do not wish to modify the code. The dimensions typically represent X-coordinate, Y-coordinate, and angle. For example, in the left-right rat running data (used in CEBRA Fig. 1 and 2), the first dimension is rat locations, while the second and third represent left (01) or right (10) running.
