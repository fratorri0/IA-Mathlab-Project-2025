# IA-Mathlab-Project-2025
This project analyze 18 songs from 3 different genres (house, rocknroll, reggaeton).
The script divide in a random way 3 songs for testing ad 3 songs for training a KNN, with windowize function every tacks is divided in window and for each window we extract the feature (like mfccs, chroma, centroid, rolloff).
After that the program classified the window using k-nn  and a DT, and find the best k-value to predict with a good accuracy wich genre is the frame.
Without retrain the model, the program repeat the classification applying a babble noise.
