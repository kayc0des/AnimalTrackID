import pandas as pd
import numpy as np
import io
from tensorflow.keras.models import load_model
import joblib
from tensorflow.keras.losses import MeanSquaredError  # Import the MSE loss function

# Load the pre-trained LSTM model
MODEL_PATH = "../../../ml-model/lstm/model/lion_movement_model.h5"

# Register custom objects (e.g., loss functions, metrics, layers)
custom_objects = {
    "mse": MeanSquaredError(),  # Register the MSE loss function
}

# Load the model with custom objects
model = load_model(MODEL_PATH, custom_objects=custom_objects)

# Load the MinMaxScaler for latitude and longitude
SCALER_PATH = "scaler/lat_lon_scaler.pkl"
lat_lon_scaler = joblib.load(SCALER_PATH)

def predict_from_csv(file_contents: bytes) -> list[dict]:
    """
    Predict latitude and longitude from a CSV file.

    Args:
        file_contents (bytes): The contents of the uploaded CSV file.

    Returns:
        list[dict]: A list of dictionaries containing the predicted latitude and longitude.
    """
    try:
        # Read the uploaded CSV file into a Pandas DataFrame
        X_test_df = pd.read_csv(io.StringIO(file_contents.decode("utf-8")))

        # Get the original shape of X_test (69, 5, 9)
        num_samples = X_test_df.shape[0]  # Number of samples (rows) in the DataFrame
        sequence_length = 5  # Original sequence length (number of time steps)
        num_features = 9  # Original number of features per time step

        # Reshape the DataFrame into a 3D NumPy array
        X_test = X_test_df.values.reshape(num_samples, sequence_length, num_features)

        # Perform prediction using the LSTM model
        predictions_scaled = model.predict(X_test)

        # Inverse transform the scaled predictions to get actual latitude and longitude
        predictions_actual = lat_lon_scaler.inverse_transform(predictions_scaled)

        # Convert the predictions to a list of dictionaries
        result = [
            {"latitude": float(pred[0]), "longitude": float(pred[1])}
            for pred in predictions_actual
        ]

        return result
    except Exception as e:
        raise ValueError(f"Error processing file: {str(e)}")