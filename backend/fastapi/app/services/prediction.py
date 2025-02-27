import numpy as np
from tensorflow.keras.models import load_model
from PIL import Image
import io

MODEL_PATH = "../../../ml-model/classifier/model/footprintclassifier_v2_shuffle.h5"
model = load_model(MODEL_PATH)

def predict_species(image_data):
    # Preprocess the image
    image = Image.open(io.BytesIO(image_data)).convert("RGB")
    image = image.resize((224, 224))  # Resize to match model input
    image_array = np.array(image) / 255.0  # Normalize
    image_array = np.expand_dims(image_array, axis=0)

    # Predict
    prediction = model.predict(image_array)
    predicted_class = np.argmax(prediction, axis=1)[0]

    # Map predicted class to species name (update this mapping as needed)
    class_to_species = {
        0: "Elephant",
        1: "Horse",
        2: "Lion",
        3: "Muledeer",
        4: "Otter",
        5: "Turkey"
    }
    return class_to_species.get(predicted_class, "Unknown")