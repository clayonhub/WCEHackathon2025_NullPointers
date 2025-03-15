
import os
import zipfile
import pandas as pd
import re
import nltk
from nltk.corpus import stopwords
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.ensemble import RandomForestClassifier
import joblib
import numpy as np

os.environ['KAGGLE_CONFIG_DIR'] = "C:\\Users\\aalha\\Downloads\\kaggle.json"


with zipfile.ZipFile("C:\\Users\\aalha\\websahayak\\archive.zip", 'r') as zip_ref:
    zip_ref.extractall("fraud_data")  

df = pd.read_csv("fraud_data/fraud_call.file", sep="\t", names=["label", "message"], on_bad_lines='warn')

nltk.download('stopwords')

df["label"] = df["label"].map({"fraud": 1, "normal": 0})

def preprocess_text(text):
    text = text.lower() 
    text = re.sub(r'\W', ' ', text)  
    text = re.sub(r'\s+', ' ', text).strip()  
    words = text.split()
    words = [word for word in words if word not in stopwords.words("english")]  
    return " ".join(words)

df["message"] = df["message"].apply(preprocess_text)

X_train, X_test, y_train, y_test = train_test_split(df["message"], df["label"], test_size=0.2, random_state=42)

vectorizer = TfidfVectorizer(max_features=5000)  
X_train_tfidf = vectorizer.fit_transform(X_train)
X_test_tfidf = vectorizer.transform(X_test)

model = RandomForestClassifier(n_estimators=200, random_state=42, class_weight="balanced")
model.fit(X_train_tfidf, y_train)

joblib.dump(model, "fraud_sms_rf.pkl")
joblib.dump(vectorizer, "vectorizer.pkl")

print("Model & vectorizer saved successfully!")

def predict_fraud(message):
    processed_message = preprocess_text(message)
    
    
    message_tfidf = vectorizer.transform([processed_message])
    
    
    prediction = model.predict(message_tfidf)
    
    if prediction == 1:
        return "⚠️ Fraud"
    else:
        return "✅ Safe"

user_input = input("Enter a message to check for fraud: ")

result = predict_fraud(user_input)
print(f"Prediction: {result}")