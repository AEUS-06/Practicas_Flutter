from fastapi import FastAPI, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware
import os, shutil, sqlite3
from predict_model import comparar_imagenes

# --- Directorios ---
PROJECT_DIR = os.path.dirname(os.path.abspath(__file__))
TEMP_DIR = os.path.join(PROJECT_DIR, "temp_images")
DB_PATH = os.path.join(PROJECT_DIR, "database.db")

os.makedirs(TEMP_DIR, exist_ok=True)

# --- Inicializar base de datos ---
def init_db():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS imagenes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre_archivo TEXT NOT NULL,
            fecha_subida TEXT DEFAULT CURRENT_TIMESTAMP
        )
    """)
    conn.commit()
    conn.close()

init_db()

# --- App FastAPI ---
app = FastAPI(title="Neural Compare API")

# --- CORS ---
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Cambia por la URL de tu app Flutter en producción
    allow_methods=["*"],
    allow_headers=["*"],
)

# --- Subir una sola imagen ---
@app.post("/subir_imagen")
async def subir_imagen(file: UploadFile = File(...)):
    try:
        file_path = os.path.join(TEMP_DIR, file.filename)
        with open(file_path, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)

        conn = sqlite3.connect(DB_PATH)
        cursor = conn.cursor()
        cursor.execute("INSERT INTO imagenes (nombre_archivo) VALUES (?)", (file.filename,))
        conn.commit()
        conn.close()

        return {"success": True, "filename": file.filename}
    except Exception as e:
        return {"success": False, "error": str(e)}

# --- Comparar dos imágenes ---
@app.post("/comparar")
async def comparar(img1: UploadFile = File(...), img2: UploadFile = File(...)):
    try:
        path1 = os.path.join(TEMP_DIR, img1.filename)
        path2 = os.path.join(TEMP_DIR, img2.filename)

        with open(path1, "wb") as f:
            shutil.copyfileobj(img1.file, f)
        with open(path2, "wb") as f:
            shutil.copyfileobj(img2.file, f)

        # Llama a tu modelo de TensorFlow
        similitud = comparar_imagenes(path1, path2)

        return {
            "success": True,
            "similitud": similitud,
            "mensaje": f"Similitud: {similitud * 100:.2f}%"
        }
    except Exception as e:
        return {"success": False, "error": str(e)}
