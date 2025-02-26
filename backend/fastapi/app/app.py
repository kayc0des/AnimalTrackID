from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.responses import JSONResponse
from datetime import datetime
from services.prediction import predict_species
from services.weather import WeatherService
from pydantic import BaseModel

app = FastAPI()
weather_service = WeatherService()

class PredictionResponse(BaseModel):
    species_name: str
    latitude: float
    longitude: float
    datetime: str
    temperature: float
    humidity: float
    pressure: float
    windspeed: float

@app.post("/predict", response_model=PredictionResponse)
async def predict(
    file: UploadFile = File(...),
    latitude: float = None,
    longitude: float = None
):
    if not latitude or not longitude:
        raise HTTPException(status_code=400, detail="Latitude and longitude are required.")

    # Step 1: Predict species from the image
    image_data = await file.read()
    species_name = predict_species(image_data)

    # Step 2: Get weather data using latitude and longitude
    weather_data = weather_service.get_weather(latitude, longitude)

    # Step 3: Prepare the response
    response = {
        "species_name": species_name,
        "latitude": latitude,
        "longitude": longitude,
        "datetime": datetime.now().isoformat(),
        "temperature": weather_data["current"]["temp"],
        "humidity": weather_data["current"]["humidity"],
        "pressure": weather_data["current"]["pressure"],
        "windspeed": weather_data["current"]["wind_speed"],
    }

    return JSONResponse(content=response)