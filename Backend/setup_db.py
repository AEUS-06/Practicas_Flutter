import sqlite3
import os

# Ruta de la carpeta Backend
PROJECT_DIR = os.path.dirname(os.path.abspath(__file__))

# Carpeta temporal de imágenes
TEMP_DIR = os.path.join(PROJECT_DIR, "temp_images")

# Archivo de base de datos
DB_PATH = os.path.join(PROJECT_DIR, "database.db")

# Crear carpeta temp_images si no existe
os.makedirs(TEMP_DIR, exist_ok=True)

# Conectar o crear la base de datos
conn = sqlite3.connect(DB_PATH)
cursor = conn.cursor()

# Crear tabla para imágenes temporales
cursor.execute("""
CREATE TABLE IF NOT EXISTS imagenes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_archivo TEXT NOT NULL,
    resultado TEXT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
""")

conn.commit()
conn.close()

print("Base de datos y tabla creadas correctamente.")
