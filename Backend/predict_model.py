# predict_model.py
import os
import numpy as np
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing import image

# Ruta del modelo entrenado
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
MODEL_PATH = os.path.join(BASE_DIR, "model.h5")

# Cargar modelo
model = load_model(MODEL_PATH)

def preprocess_image(img_path, target_size=(128, 128)):
    """
    Carga y procesa la imagen para que sea compatible con el modelo.
    """
    img = image.load_img(img_path, target_size=target_size)
    img_array = image.img_to_array(img) / 255.0
    img_array = np.expand_dims(img_array, axis=0)
    return img_array

def predict_image(img_path):
    """
    Devuelve 1 si la imagen es "similares", 0 si es "no similares".
    """
    img_array = preprocess_image(img_path)
    pred = model.predict(img_array)[0][0]
    return float(pred)  # retorna entre 0 y 1

def comparar_imagenes(img_path1, img_path2):
    """
    Compara dos imágenes y devuelve un porcentaje de similitud.
    Por simplicidad, usamos la media de las predicciones de ambas imágenes.
    """
    pred1 = predict_image(img_path1)
    pred2 = predict_image(img_path2)

    # Similitud: 1 - diferencia absoluta (simple)
    similitud = 1 - abs(pred1 - pred2)
    return float(similitud)
