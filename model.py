import pyaudio
import wave
import speech_recognition as sr
import joblib
import re
from nltk.stem import WordNetLemmatizer
import nltk

nltk.download('wordnet')

model = joblib.load('fraudmodel5.pkl')
vectorizer = joblib.load('fraudvectorizer5.pkl')

flagged_words = [
    "urgent", "payment", "prize", "winner", "congratulations", "lottery", "act now", "cash", 
    "credit card", "verification", "refund", "click here", "account blocked", "limited time", 
    "scam", "risk-free", "claim", "exclusive offer", "investment", "update your details",
    "pay now", "wire transfer", "bank account", "password reset", "sweepstakes", "bonus",
    "guaranteed income", "loan approval", "you have been selected", "confirm immediately"
]

def clean_text(text):
    lemmatizer = WordNetLemmatizer()
    text = text.lower()
    text = re.sub(r'[^a-zA-Z0-9\s]', '', text)  
    text = re.sub(r'\d+', '', text)             
    text = ' '.join(lemmatizer.lemmatize(word) for word in text.split())  
    for word in flagged_words:
        if word in text:
            text += ' fraud_keyword' 
    return text.strip()


audio_stream = pyaudio.PyAudio()

rate = 16000 
chunk_size = 1024  
channels = 1 
format = pyaudio.paInt16 

stream = audio_stream.open(format=format, channels=channels, rate=rate,
                           input=True, frames_per_buffer=chunk_size)

print("Recording... (Press Ctrl + C to stop)")

frames = []

try:
    while True:
        data = stream.read(chunk_size)
        frames.append(data)
except KeyboardInterrupt:
    print("Recording stopped by user.")


stream.stop_stream()
stream.close()

audio_file = "test_audio.wav"
with wave.open(audio_file, 'wb') as wf:
    wf.setnchannels(channels)
    wf.setsampwidth(audio_stream.get_sample_size(format))
    wf.setframerate(rate)
    wf.writeframes(b''.join(frames))

print(f"Audio saved as {audio_file}")

recognizer = sr.Recognizer()

with sr.AudioFile(audio_file) as source:
    audio = recognizer.record(source) 

    try:
        
        text = recognizer.recognize_google(audio)
        print("Recognized text:", text)

        
        cleaned_text = clean_text(text)

        
        text_tfidf = vectorizer.transform([cleaned_text])
        prediction = model.predict(text_tfidf)

        if prediction[0] == 1:
            print("🚨 Fraudulent speech detected! 🚨")
        else:
            print("✅ No fraud detected.")

    except sr.UnknownValueError:
        print("Google Speech Recognition could not understand the audio.")
    except sr.RequestError as e:
        print(f"Error with Google Speech Recognition service: {e}")