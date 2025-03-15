from flask import Flask, request, jsonify
import joblib
import speech_recognition as sr
import os

app = Flask(__name__)

# Load models
text_model = joblib.load("fraud_sms_rf.pkl")
text_vectorizer = joblib.load("vectorizer.pkl")
speech_model = joblib.load("fraudmodel5.pkl")
speech_vectorizer = joblib.load("fraudvectorizer5.pkl")

# Function to predict fraud in text
def predict_text_fraud(message):
    processed_text = message.lower()
    message_tfidf = text_vectorizer.transform([processed_text])
    prediction = text_model.predict(message_tfidf)
    return "⚠️ Fraud" if prediction[0] == 1 else "✅ Safe"

# Function to process speech and predict fraud
def predict_speech_fraud(audio_file):
    recognizer = sr.Recognizer()
    with sr.AudioFile(audio_file) as source:
        audio = recognizer.record(source)
    try:
        text = recognizer.recognize_google(audio)
        print("Recognized Speech:", text)
        message_tfidf = speech_vectorizer.transform([text])
        prediction = speech_model.predict(message_tfidf)
        return "🚨 Fraudulent Speech" if prediction[0] == 1 else "✅ Safe Speech"
    except:
        return "❌ Speech not recognized"

@app.route("/predict_text", methods=["POST"])
def predict_text():
    data = request.get_json()
    message = data.get("message", "")
    result = predict_text_fraud(message)
    return jsonify({"result": result})

@app.route("/predict_speech", methods=["POST"])
def predict_speech():
    audio_file = request.files["file"]
    audio_path = "temp_audio.wav"
    audio_file.save(audio_path)
    result = predict_speech_fraud(audio_path)
    os.remove(audio_path)
    return jsonify({"result": result})

if __name__ == "__main__":
    app.run(debug=True)
