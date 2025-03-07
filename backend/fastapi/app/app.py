from fastapi import FastAPI, File, UploadFile, HTTPException, Form
from fastapi.responses import JSONResponse
from datetime import datetime
from services.prediction import predict_species
from services.weather import WeatherService
from pydantic import BaseModel
from datetime import datetime
from typing import Optional
from connection import connect_db

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
    latitude: float = Form(...),
    longitude: float = Form(...),
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

class TrackEntry(BaseModel):
    user_uuid: str
    species: str
    latitude: float
    longitude: float
    datetime: str
    temperature: float
    humidity: float
    pressure: float
    wind_speed: float

@app.post("/add_track/")
async def add_track(entry: TrackEntry):
    """Insert a classification result into the tracks table"""

    conn = await connect_db()
    if not conn:
        raise HTTPException(status_code=500, detail="Database connection failed")

    try:
        # Insert track entry
        await conn.execute("""
            INSERT INTO tracks (user_uuid, species, latitude, longitude, datetime, temperature, pressure, humidity, wind_speed)
            VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
        """, entry.user_uuid, entry.species, entry.latitude, entry.longitude, entry.datetime, entry.temperature, entry.pressure, entry.humidity, entry.wind_speed)
        
        return {"message": "Track added successfully!"}

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {e}")
    finally:
        await conn.close()