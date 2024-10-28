This repository contains everything you need to reproduce all the 17 figures from:\
Neural Embeddings Rank: Aligning 3D latent dynamics with movements.\
Chenggang Chen, Zhiyu Yang, and Xiaoqin Wang. NeurIPS 2024  
This works has also been accecpt by The First Workshop on NeuroAI @ NeurIPS2024:\
https://neuroai-workshop.github.io  
And NeurIPS 2024 Workshop: Self-Supervised Learning (SSL) - Theory and Practice as **Oral**\
https://sslneurips2024.github.io/index.html  
NER has recieved eight reviews. All of the reviews are above borderline accecpt(5) and revierwers who gave higher scores are also more confident:\
NeurIPS: Scores: 7, 7, 6, Confidence: 4, 3, 1  
NeuroAI: Scores: 9, 7, 7, Confidence: 5, 4, 3  
SSL:     Scores: 8, 7, 7, Confidence: 2, 4  
NER is the first dimensionality reduction method which align 3D latenct dynamics with movements\
![alt text](https://github.com/NeuroscienceAI/NER/blob/main/NER_Figs_pdf/demo_crop_compress.gif)\
Left: Hand velocities of center-out reaching in eight directions (colors). Right: 3D latent dynamics

All of our network training and figures (include above demo videos) are generated through the 43 Jupyter Notebook files in folder "NER_Figs_ipynb".\
NER modified the loss function in CEBRA so as long as you could run CEBRA (regradless of version) then you could run NER.\
To train NER after you have made CEBRA works, there are two options: 1) Replace the original cebra folder (contains folder data, datasets, ..., solver) under your main cebra folder with downloaded "NER_Code_1021" folder or 2) Modify the original cebra folder following the instruction (NER changes to CEBRA.pdf) inside the "NER_Code_1021" folder.

"data" folder contains the raw data after smoothing with Gaussion kernal. Since raw data is Matlab format so we also processed raw data with Matlab (Matlab codes are also included).\
"data_NER" folder containes the intermediate results (.npz) after training 

FAQ:
1. Have you optimized the hyper-parametrs of CEBRA? No.\
2. What is the limination of NER relative to CEBRA? Need continuous labels. \
3. What kinds of data are appropriate for NER? Continuous labels like hand or body movements.\
