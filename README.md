This repository contains everything you need to reproduce all the 17 figures from:\
Neural Embeddings Rank: Aligning 3D latent dynamics with movements.\
Chenggang Chen, Zhiyu Yang, and Xiaoqin Wang. NeurIPS 2024  
This works has also been accecpt by The First Workshop on NeuroAI @ NeurIPS2024:\
https://neuroai-workshop.github.io  
And NeurIPS 2024 Workshop: Self-Supervised Learning (SSL) @ NeurIPS2024 as an **Oral** presentation\
https://sslneurips2024.github.io/index.html  
NER has recieved eight reviews. All of the reviews are above borderline accecpt(5) and revierwers who gave higher scores are also more confident:\
NeurIPS: Scores: 7, 7, 6, Confidence: 4, 3, 1  
NeuroAI: Scores: 9, 7, 7, Confidence: 5, 4, 3  
SSL:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Scores: 8, 7, 7, Confidence: 2, 4  
NER is the first dimensionality reduction method that can reveal movements-aligned 3D latenct dynamics\
![alt text](https://github.com/NeuroscienceAI/NER/blob/main/NER_Figs_pdf/demo_crop_compress.gif)\
Left: Hand velocities of center-out reaching in eight directions (colors). Right: 3D latent dynamics

All of our network training are generated through the 43 Jupyter Notebook files in folder "NER_Figs_ipynb".\
NER modified the loss function in CEBRA so as long as you could run CEBRA (regradless of version) then you could run NER.\
To train NER after you have made CEBRA works, there are two options: 1) Replace the original cebra folder (contains folder data, datasets, ..., solver) under your main cebra folder with downloaded "NER_Code_1021" folder or 2) Modify the original cebra folder following the instruction (NER changes to CEBRA.pdf) inside the "NER_Code_1021" folder.

"data" folder contains the raw data after smoothing with Gaussion kernal. Since raw data is Matlab format so we also processed raw data with Matlab (Matlab codes are also included).\
"data_NER" folder containes the intermediate results (.npz) after network training and will be loaded by Jupyter Notebook in the "NER_Figs_ipynb" folder to generate .pdf figures (include above demo videos) saved inside "NER_Figs_pdf" folder.

FAQ:
1. Have you optimized the hyper-parametrs of CEBRA? No. We fixed the time-offset to 1 timebin and temperautre to 1. We understand grid-search the hyperparamteres can definitely improve the perfromance of both NER and CEBRA.
2. What is the limination of NER relative to CEBRA? NER need continuous labels that could be ranked, such as velocitities, positions,and angles. It is not designed for discrete classes such as the video decoding used in CEBRA paper (their Fig. 4 and 5) where the 900 frames are uncorrelated. However, it is still possible to rank the video embeddings (extracted by DINO), although the performance is no better than CEBRA. The other limitation is that the execution time of NER is almost two times longer than CEBRA. 
3. What kinds of data are appropriate for NER? Continuous labels like hand or body movements. Labels should have same length of neural data and should be three dimensions if you do not want to modify the code. Those three dimensions are X-coordinate, Y-coordinates and angles. For the left-right rat runing data used in Fig. 1 and 2 of CEBRA paper, the first dimension is rat locations, and second and third dimension is either 01 for left runing and 10 for right running. 
