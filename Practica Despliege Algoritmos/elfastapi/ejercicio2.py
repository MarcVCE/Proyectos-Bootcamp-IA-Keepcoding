from fastapi import FastAPI
from transformers import pipeline

app = FastAPI()

# Pipelines de Hugging Face
sentiment = pipeline("sentiment-analysis")
summarizer = pipeline("summarization")

@app.get("/")
def root():
    return {"message": "API activa"}

@app.get("/saludo")
def saludo(nombre: str = "usuario"):
    return {"saludo": f"Hola, {nombre}!"}

@app.get("/doble")
def doble(num: int):
    return {"doble": num * 2}

@app.get("/sentimiento")
def sentimiento(texto: str):
    result = sentiment(texto)[0]
    return {"label": result["label"], "score": round(result["score"], 2)}

@app.get("/resumen")
def resumen(texto: str):
    result = summarizer(texto, max_length=50, min_length=5, do_sample=False)[0]
    return {"resumen": result["summary_text"]}
