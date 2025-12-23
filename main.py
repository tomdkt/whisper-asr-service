from fastapi import FastAPI, File, UploadFile, Query
import whisper
import os
import shutil
import tempfile

app = FastAPI()

# Load model based on environment variable
model_name = os.getenv("ASR_MODEL", "base")
model = whisper.load_model(model_name)

@app.post("/asr")
async def transcribe(
    audio_file: UploadFile = File(...),
    task: str = Query("transcribe"),
    language: str = Query(None)
):
    with tempfile.NamedTemporaryFile(delete=False, suffix=os.path.splitext(audio_file.filename)[1]) as tmp:
        shutil.copyfileobj(audio_file.file, tmp)
        tmp_path = tmp.name

    try:
        result = model.transcribe(tmp_path, task=task, language=language)
        return result["text"].strip()
    finally:
        if os.path.exists(tmp_path):
            os.remove(tmp_path)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=9000)
