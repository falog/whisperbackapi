from fastapi import FastAPI, UploadFile, File
import whisper

app = FastAPI()
model = whisper.load_model("small", download_root="/root/.cache/whisper")


@app.post("/transcribe")
async def transcribe(file: UploadFile = File(...)):
    audio = await file.read()
    
    with open("temp_audio.wav", "wb") as f:
        f.write(audio)

    result = model.transcribe("temp_audio.wav")
    return {"text": result["text"]}
