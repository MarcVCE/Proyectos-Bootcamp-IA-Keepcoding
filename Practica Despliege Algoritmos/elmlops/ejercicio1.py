import pandas as pd
import numpy as np
import mlflow
import mlflow.sklearn

from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression

from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler

from sklearn.metrics import precision_score, recall_score

from sklearn.datasets import load_wine

# Dataset cambiado
wine = load_wine()
df = pd.DataFrame(wine['data'], columns=wine['feature_names'])
df['target'] = wine['target']

# División en train/test
train, test = train_test_split(df, test_size=0.2, random_state=123, stratify=df['target'])

# Guardar test
test_target = test['target']
test[['target']].to_csv('test-target.csv', index=False)
del test['target']
test.to_csv('test.csv', index=False)

# Separar variables
features = [x for x in list(train.columns) if x != 'target']
x_raw = train[features]
y_raw = train['target']

x_train, x_test, y_train, y_test = train_test_split(x_raw, y_raw,
                                                    test_size=0.20,
                                                    random_state=123,
                                                    stratify=y_raw)

# Modelo cambiado: Logistic Regression
clf = LogisticRegression(max_iter=1000, class_weight='balanced', random_state=123)

preprocessor = Pipeline(steps=[('scaler', StandardScaler())])

model = Pipeline(steps=[('preprocessor', preprocessor),
                        ('LogisticRegression', clf)])

# Entrenamiento
model.fit(x_train, y_train)

# Evaluación
y_pred = model.predict(x_test)
accuracy_train = model.score(x_train, y_train)
accuracy_test = model.score(x_test, y_test)
precision = precision_score(y_test, y_pred, average='macro')
recall = recall_score(y_test, y_pred, average='macro')

# MLOps con MLflow
mlflow.set_experiment("wine-classification-mlops")
with mlflow.start_run(run_name="wine-logreg-run"):
    mlflow.log_param("model", "LogisticRegression")
    mlflow.log_param("max_iter", 1000)
    mlflow.log_metric("accuracy_train", accuracy_train)
    mlflow.log_metric("accuracy_test", accuracy_test)
    mlflow.log_metric("precision", precision)
    mlflow.log_metric("recall", recall)
    
    mlflow.sklearn.log_model(model, "clf", registered_model_name="wine_classifier")

print("Entrenamiento y logging completados.")
