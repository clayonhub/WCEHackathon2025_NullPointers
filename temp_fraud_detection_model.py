    # -*- coding: utf-8 -*-
    """fraud_detection_model.ipynb

    Automatically generated by Colab.

    Original file is located at
        https://colab.research.google.com/drive/1geGroZRsjQUyN8KDxctyx44i-GxjOVYb
    """

    !pip install pandas scikit-learn joblib kaggle

    from google.colab import files
    files.upload()  # Upload kaggle.json file here

    !mkdir -p ~/.kaggle
    !mv kaggle.json ~/.kaggle/
    !chmod 600 ~/.kaggle/kaggle.json

    !kaggle datasets download -d narayanyadav/fraud-call-india-dataset
    !unzip fraud-call-india-dataset.zip

    !ls

    import zipfile

    with zipfile.ZipFile("fraud-call-india-dataset.zip", 'r') as zip_ref:
        zip_ref.extractall("fraud_data")  # Extracts to a folder named fraud_data

    !ls fraud_data

    import pandas as pd

    # Load dataset
    # Use error_bad_lines=False to skip lines with errors
    # Also added on_bad_lines='warn' to print warning for bad lines
    df = pd.read_csv("fraud_call.file", sep="\t", names=["label", "message"], on_bad_lines='warn')

    # Display first few rows
    df.head()

    import re
    import nltk
    from nltk.corpus import stopwords

    # Download stopwords
    nltk.download('stopwords')

    # Convert labels to binary (fraud=1, normal=0)
    df["label"] = df["label"].map({"fraud": 1, "normal": 0})

    # Function to clean text
    def preprocess_text(text):
        text = text.lower()  # Convert to lowercase
        text = re.sub(r'\W', ' ', text)  # Remove special characters
        text = re.sub(r'\s+', ' ', text).strip()  # Remove extra spaces
        words = text.split()
        words = [word for word in words if word not in stopwords.words("english")]  # Remove stopwords
        return " ".join(words)

    # Apply text preprocessing
    df["message"] = df["message"].apply(preprocess_text)

    # Display cleaned data
    df.head()

    from sklearn.model_selection import train_test_split
    from sklearn.feature_extraction.text import TfidfVectorizer
    from sklearn.linear_model import LogisticRegression
    from sklearn.metrics import accuracy_score, classification_report

    # Step 1: Split Data
    X_train, X_test, y_train, y_test = train_test_split(df["message"], df["label"], test_size=0.2, random_state=42)

    # Step 2: Convert Text to Numerical Features using TF-IDF
    vectorizer = TfidfVectorizer(max_features=5000)  # Limit features to 5000 for efficiency
    X_train_tfidf = vectorizer.fit_transform(X_train)
    X_test_tfidf = vectorizer.transform(X_test)

    # Step 3: Train Logistic Regression Model
    model = LogisticRegression()
    model.fit(X_train_tfidf, y_train)

    # Step 4: Evaluate Model
    #y_pred = model.predict(X_test_tfidf)
    y_pred_proba = model.predict_proba(X_test_tfidf)[:, 1]  # Get spam probability scores
    threshold = 0.3  # Lowering the threshold (default is 0.5)
    y_pred = (y_pred_proba >= threshold).astype(int)  # Classify as spam if probability >= 0.3

    accuracy = accuracy_score(y_test, y_pred)

    print(f"Model Accuracy: {accuracy * 100:.2f}%")
    print("\nClassification Report:\n", classification_report(y_test, y_pred))

    import joblib

    # Save the trained model
    joblib.dump(model, "spam_classifier.pkl")

    # Save the TF-IDF vectorizer
    joblib.dump(vectorizer, "tfidf_vectorizer.pkl")

    print("Model & vectorizer saved successfully!")

    # Sample messages to test
    test_messages = [
        "Dear Sir/Maam, we are pleased to inform your eligibility for interview with salary 18880Rs, Click wa.me/919241799063 Career Hub",  # Likely spam
        "someone from Cummins Clg secretly voted for you on Wyb! check now: https://link.wyb.social/dl/tbh?sld=SYGVTQ",  # Likely not spam
        "Urgent! Your bank account has been compromised. Call us immediately at 123-456-7890.",  # Likely spam
        "Your package is out for delivery and will arrive today.",  # Likely not spam
        "Claim your free prize now! Limited time offer. Act fast!",  # Likely spam
    ]

    # Convert messages to TF-IDF
    test_messages_tfidf = vectorizer.transform(test_messages)

    # Predict
    predictions = model.predict(test_messages_tfidf)

    # Show results
    for msg, pred in zip(test_messages, predictions):
        label = "⚠️ Fraud" if pred == 1 else "✅ Safe"
        print(f"Message: {msg}\nPrediction: {label}\n")

    print(df['label'].value_counts())  # Check dataset balance

    vectorizer = TfidfVectorizer(max_features=10000, ngram_range=(1,2), stop_words="english")
    # Re-fit TF-IDF vectorizer on training data
    vectorizer = TfidfVectorizer(max_features=5000)
    X_train_tfidf = vectorizer.fit_transform(X_train)  # Fit on training data
    X_test_tfidf = vectorizer.transform(X_test)  # Transform test data

    # Re-train the model
    model = LogisticRegression()
    model.fit(X_train_tfidf, y_train)

    from sklearn.ensemble import RandomForestClassifier

    model = RandomForestClassifier(n_estimators=200, random_state=42, class_weight="balanced")  # Balance classes
    model.fit(X_train_tfidf, y_train)

    import numpy as np
    import re

    # Function to extract features
    def extract_features(text):
        return [
            len(text),  # Message length
            sum(1 for char in text if char in "!$₹%"),  # Special characters count
            len(re.findall(r"https?://\S+|www\.\S+", text)),  # URL count
            len(re.findall(r'\b\d{10,}\b', text))  # Phone number count
        ]

    # Apply feature extraction
    X_train_extra = np.array([extract_features(text) for text in X_train])
    X_test_extra = np.array([extract_features(text) for text in X_test])

    # Convert to TF-IDF and stack with new features
    from scipy.sparse import hstack

    X_train_tfidf = hstack([X_train_tfidf, X_train_extra])
    X_test_tfidf = hstack([X_test_tfidf, X_test_extra])

    threshold = 0.2  # Reduce threshold to classify more messages as fraud
    y_pred = (y_pred_proba >= threshold).astype(int)

    from imblearn.over_sampling import SMOTE

    smote = SMOTE(random_state=42)
    X_train_balanced, y_train_balanced = smote.fit_resample(X_train_tfidf, y_train)

    import numpy as np
    import pandas as pd
    from sklearn.model_selection import train_test_split
    from sklearn.feature_extraction.text import TfidfVectorizer
    from sklearn.ensemble import RandomForestClassifier
    from sklearn.metrics import accuracy_score, classification_report
    from scipy.sparse import hstack
    from imblearn.over_sampling import SMOTE

    # Custom Spam Keywords
    spam_keywords = ["win", "lottery", "cash", "prize", "offer", "free", "click", "eligibility", "wa.me", "urgent", "guaranteed", "call now"]
    df["contains_spam_word"] = df["message"].apply(lambda x: any(word in x.lower() for word in spam_keywords)).astype(int)

    # Extra Features: Message Length and Special Characters
    df['message_length'] = df['message'].apply(len)
    df['num_special_chars'] = df['message'].apply(lambda x: sum(1 for char in x if char in "!@#$%^&*()_+={}[]|:;'<>,.?/~"))

    # Split Data
    X_train, X_test, y_train, y_test = train_test_split(df[["message", "message_length", "num_special_chars", "contains_spam_word"]],
                                                        df["label"], test_size=0.2, random_state=42)

    # Convert Text to Numerical Features using TF-IDF
    vectorizer = TfidfVectorizer(max_features=7000, ngram_range=(1,2))  # Includes single words + bigrams
    X_train_tfidf = vectorizer.fit_transform(X_train["message"])
    X_test_tfidf = vectorizer.transform(X_test["message"])

    # Combine TF-IDF with Extra Features
    X_train_combined = hstack([X_train_tfidf, np.array(X_train[['message_length', 'num_special_chars', 'contains_spam_word']])])
    X_test_combined = hstack([X_test_tfidf, np.array(X_test[['message_length', 'num_special_chars', 'contains_spam_word']])])

    # Handle Class Imbalance using SMOTE
    smote = SMOTE(sampling_strategy=0.9, random_state=42)  # Make fraud samples almost equal to safe
    X_train_resampled, y_train_resampled = smote.fit_resample(X_train_combined, y_train)

    # Train Random Forest Model
    model = RandomForestClassifier(n_estimators=300, max_depth=20, random_state=42, class_weight="balanced")
    model.fit(X_train_resampled, y_train_resampled)

    # Evaluate Model
    y_pred_proba = model.predict_proba(X_test_combined)[:, 1]  # Get fraud probability scores
    threshold = 0.2  # Lower threshold to catch all fraud
    y_pred = (y_pred_proba >= threshold).astype(int)

    accuracy = accuracy_score(y_test, y_pred)

    print(f"Model Accuracy: {accuracy * 100:.2f}%")
    print("\nClassification Report:\n", classification_report(y_test, y_pred))

    # Save Model and Vectorizer
    import joblib
    joblib.dump(model, "fraud_sms_rf.pkl")
    joblib.dump(vectorizer, "vectorizer.pkl")