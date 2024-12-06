This repository provides everything needed to reproduce all 17 figures from:\
Neural Embeddings Rank: Aligning 3D Latent Dynamics with Movements\
**Chenggang Chen**, Zhiyu Yang, and Xiaoqin Wang. *NeurIPS 2024* (**Top 2%**)\
https://nips.cc/virtual/2024/poster/95804

This work has also been accepted by:\
The First NeuroAI Workshop @ NeurIPS 2024:\
https://neuroai-workshop.github.io  
The Fifth Self-Supervised Learning (SSL) Workshop @ NeurIPS 2024 as an **Oral** presentation:\
https://sslneurips2024.github.io/index.html  

NER has received eight reviews.\
All reviews are above borderline acceptance (score 5), with reviewers giving higher scores also reporting higher confidence:\
NeurIPS&nbsp;: Scores: 7, 7, 6; Confidence: 4, 3, 1  
NeuroAI&nbsp;: Scores: 9, 7, 7; Confidence: 5, 4, 3  
SSL(Oral): Scores: 8, 7&nbsp;&nbsp;&nbsp;&nbsp;; Confidence: 2, 4

NER is the first dimensionality reduction method capable of revealing movement-aligned 3D latent dynamics:
![alt text](https://github.com/NeuroscienceAI/NER/blob/main/NER_Figs_pdf/demo_crop_compress.gif)\
Left: Hand velocities of center-out reaching in eight directions (color-coded).
Right: 3D latent dynamics

All network training can be reproduced through the Jupyter Notebooks in the "NER_Figs_ipynb" folder.\
NER modifies CEBRA’s loss function, so if you can run CEBRA (any version), you can run NER.\
To train NER after setting up CEBRA, you have two options:
1. Replace the original cebra folder (containing data, ..., solver) in your main CEBRA folder with the downloaded "NER_Code_1021" folder.
2. Follow the instructions in "NER_Code_1021" (see NER changes to CEBRA.pdf) to modify the original .py files in cebra folder.

The "data" folder contains the smoothed raw data (spike counts). Since the raw data is in MATLAB format, we also processed it with MATLAB (MATLAB code included).\
The "data_NER" folder contains intermediate results (.npz) after network training, which the Jupyter Notebooks in "NER_Figs_ipynb" use to generate .pdf figures (including demo videos) saved in the "NER_Figs_pdf" folder.
![alt text](https://github.com/NeuroscienceAI/NER/blob/main/NER_Figs_pdf/NER%20poster.png)
**FAQ:**

Have you optimized CEBRA’s hyperparameters? No. We fixed the time offset to 1 time bin and temperature to 1. While grid-searching hyperparameters would likely improve both NER and CEBRA performance, we did not perform this step.

What limitations does NER have compared to CEBRA? NER requires continuous labels that can be ranked, such as velocities, positions, or angles. It isn’t suited for discrete classes, as demonstrated in CEBRA’s video decoding (CEBRA Fig. 4 and 5), where ranking the 900 frames using a distance metric is challenging. However, ranking video embeddings extracted by DINO is possible since the video embeddings remain continuous in 2D, though the performance does not exceed CEBRA. Additionally, NER’s execution time is nearly double that of CEBRA.

What types of data work best for NER? Continuous labels like hand or body movements are ideal. Labels must match the neural data length and should be three-dimensional if you do not wish to modify the code. The dimensions typically represent X-coordinate, Y-coordinate, and angle. Notice that in the left-right rat running data (used in CEBRA Fig. 1 and 2), the first dimension is rat locations, while the second and third represent left (01) or right (10) running.
