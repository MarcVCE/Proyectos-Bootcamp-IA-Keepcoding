import json
import pandas as pd
import spacy

# Cargar modelo spaCy en inglés
nlp = spacy.load("en_core_web_sm")

# Stopwords importantes para sentimientos
important_stopwords = {"not", "no", "never", "n't", "why", "how", "what"}
# Signos de puntuación relevantes
important_punct = {"!", "?"}

def preprocess_text_sentiment(doc):
    tokens = []
    for token in doc:
        if token.is_space:
            continue
        if token.is_stop and token.text.lower() not in important_stopwords:
            continue
        if token.is_punct and token.text not in important_punct:
            continue
        if token.is_alpha or token.text in important_punct:
            tokens.append(token.lemma_.lower())
    return " ".join(tokens)

def extract_sentiment_features(json_path):
    with open(json_path, mode='r', encoding='utf-8') as f:
        data = json.load(f)

    processed = []
    for item in data:
        text = item["review_text"]
        rating = int(item["rating"])
        doc = nlp(text)
        cleaned_text = preprocess_text_sentiment(doc)

        features = {
            "clean_text": cleaned_text,
            "review_length": len(text),
            "num_tokens": len(doc),
            "num_sentences": len(list(doc.sents)),
            "num_nouns": sum(1 for token in doc if token.pos_ == "NOUN"),
            "num_verbs": sum(1 for token in doc if token.pos_ == "VERB"),
            "num_adjectives": sum(1 for token in doc if token.pos_ == "ADJ"),
            "num_adverbs": sum(1 for token in doc if token.pos_ == "ADV"),
            "has_exclamation": int("!" in text),
            "has_question": int("?" in text),
            "rating": 1 if rating >= 5 else 0
        }

        processed.append(features)

    return pd.DataFrame(processed)
