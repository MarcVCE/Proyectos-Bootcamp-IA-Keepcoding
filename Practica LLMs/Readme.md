# 🧠 Modelo de Resumen Fine-Tuned con BART

Este repositorio contiene el código y resultados del fine-tuning de un modelo BART para tareas de resumen automático de textos históricos además de la transcripción de esos resumenes a imagenes representativas.

🚀 **Modelo disponible en Hugging Face (publicado bajo pseudónimo):**
👉 [Pedro32183290/bart-stablediffusion-pipeline](https://huggingface.co/Pedro32183290/bart-stablediffusion-pipeline)

---

## 📊 Resultados del entrenamiento

| Epoch | Training Loss | Validation Loss | Rouge1 | Rouge2 | RougeL | RougeLsum |
|-------|----------------|------------------|--------|--------|--------|-----------|
| 1     | 0.9813         | 0.4156           | 0.8210 | 0.8027 | 0.8167 | 0.8186    |
| 2     | 0.2494         | 0.1727           | 0.8186 | 0.8009 | 0.8165 | 0.8169    |
| 3     | 0.1275         | 0.1340           | 0.8245 | 0.8063 | 0.8214 | 0.8235    |

✅ Resultados estables y sin señales de sobreajuste.

---
