import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report, accuracy_score # type: ignore
import re
from nltk.stem import WordNetLemmatizer
import joblib  # For saving the model
import nltk
nltk.download('wordnet')

# Load the dataset
dataset_path = 'C:\\Users\\aalha\\websahayak\\fraud_call.file'
df = pd.read_csv(dataset_path, sep='\t', header=None, names=['label', 'text'], on_bad_lines='skip')

# List of suspicious keywords for better detection
flagged_words = [
    "urgent", "payment", "prize", "winner", "congratulations", "lottery", "act now", "cash", 
    "credit card", "verification", "refund", "click here", "account blocked", "limited time", 
    "scam", "risk-free", "claim", "exclusive offer", "investment", "update your details",
    "pay now", "wire transfer", "bank account", "password reset", "sweepstakes", "bonus",
    "guaranteed income", "loan approval", "you have been selected", "confirm immediately"
]

# Clean the text with improved processing
def clean_text(text):
    lemmatizer = WordNetLemmatizer()
    text = text.lower()
    text = re.sub(r'[^a-zA-Z0-9\s]', '', text)  # Remove special characters
    text = re.sub(r'\d+', '', text)              # Remove numbers
    text = ' '.join(lemmatizer.lemmatize(word) for word in text.split())  # Lemmatization
    for word in flagged_words:
        if word in text:
            text += ' fraud_keyword'  # Add special token for flagged words
    return text.strip()

df['text'] = df['text'].apply(clean_text)

# Encode labels
df['label'] = df['label'].map({'fraud': 1, 'normal': 0})

# Split data into train and test sets
X_train, X_test, y_train, y_test = train_test_split(df['text'], df['label'], test_size=0.3, random_state=42)

# Vectorize text using TF-IDF
vectorizer = TfidfVectorizer(max_features=5000)
X_train_tfidf = vectorizer.fit_transform(X_train)
X_test_tfidf = vectorizer.transform(X_test)

# Train the model with class weight balancing
model = LogisticRegression(class_weight='balanced', max_iter=1000)
model.fit(X_train_tfidf, y_train)

# Evaluate the model
y_pred = model.predict(X_test_tfidf)
print(f"Model accuracy: {accuracy_score(y_test, y_pred):.2f}")
print(classification_report(y_test, y_pred))

# Save the model and vectorizer
joblib.dump(model, 'fraudmodel5.pkl')  # Save the model to 'fraudmodel5.pkl'
joblib.dump(vectorizer, 'fraudvectorizer5.pkl')  # Save the vectorizer to 'fraudvectorizer5.pkl'

print("Model and vectorizer saved successfully as 'fraudmodel5.pkl' and 'fraudvectorizer5.pkl'!")


print("Data prepared, model trained, and saved successfully!")
