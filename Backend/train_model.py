# train_model.py
import os
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from model import create_model

# Rutas
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_DIR = os.path.join(BASE_DIR, "data")
TRAIN_DIR = DATA_DIR  # contiene "similares" y "no_similares"
MODEL_PATH = os.path.join(BASE_DIR, "model.h5")

# Generador de imágenes con aumento de datos
datagen = ImageDataGenerator(
    rescale=1./255,
    validation_split=0.2,  # 20% para validación
    rotation_range=20,
    width_shift_range=0.1,
    height_shift_range=0.1,
    horizontal_flip=True
)

train_generator = datagen.flow_from_directory(
    TRAIN_DIR,
    target_size=(128, 128),
    batch_size=16,
    class_mode='binary',
    subset='training'
)

val_generator = datagen.flow_from_directory(
    TRAIN_DIR,
    target_size=(128, 128),
    batch_size=16,
    class_mode='binary',
    subset='validation'
)

# Crear modelo
model = create_model()

# Entrenar
model.fit(
    train_generator,
    validation_data=val_generator,
    epochs=10
)

# Guardar modelo
model.save(MODEL_PATH)
print(f"Modelo entrenado y guardado en {MODEL_PATH}")
