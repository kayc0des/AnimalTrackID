from fastapi import FastAPI, File, UploadFile, HTTPException, Form
from fastapi.responses import JSONResponse
from datetime import datetime
from services.prediction import predict_species
from services.weather import WeatherService
from pydantic import BaseModel
from datetime import datetime
from connection import connect_db
import os
import cloudinary
import cloudinary.uploader
from dotenv import load_dotenv

load_dotenv()

app = FastAPI()
weather_service = WeatherService()

cloudinary.config(
    cloud_name = os.getenv("CLOUD_NAME"),
    api_key = os.getenv("API_KEY"),
    api_secret = os.getenv("API_SECRET_KEY"),
    secure=True
)

class PredictionResponse(BaseModel):
    species_name: str
    latitude: float
    longitude: float
    datetime: str
    temperature: float
    humidity: float
    pressure: float
    windspeed: float
    
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


""" --------------- Classify Footprint --------------- """

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


""" --------------- Store Succesful Track Classification --------------- """

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


""" --------------- Data Submissions --------------- """

@app.post("/upload/")
async def upload_image(userID: str, name: str, file: UploadFile = File(...)):

    file_extension = os.path.splitext(file.filename)[1]
    new_filename = f"{name}_{datetime.now().strftime('%Y%m%d%H%M%S')}{file_extension}"
    
    try:
        file_content = await file.read()
        upload_result = cloudinary.uploader.upload(file_content, public_id=new_filename)
        link = upload_result["secure_url"]
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Cloudinary upload error: {str(e)}")
    
    try:
        conn = await connect_db()
        if not conn:
            raise HTTPException(status_code=500, detail="Database connection failed")

        await conn.execute(
            "INSERT INTO data_submission (user_uuid, species_name, image_url) VALUES ($1, $2, $3)",
            userID, name, link
        )
        print("Record inserted successfully")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        await conn.close()
    
    return {"uuid": userID, "name": name, "link": link}


""" --------------- Tracks/User --------------- """

@app.get("/tracks/{user_id}")
async def get_tracks(user_id: str):

    try:
        conn = await connect_db()
        if not conn:
            raise HTTPException(status_code=500, detail="Database connection failed")
        

        rows = await conn.fetch(
            "SELECT species, latitude, longitude FROM tracks WHERE user_uuid = $1",
            user_id
        )
        
        tracks = [dict(row) for row in rows]
        
        return {"user_uuid": user_id, "tracks": tracks}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        await conn.close()
        

""" --------------- All Tracks --------------- """

@app.get("/alltracks")
async def get_all_track_records():
    
    try:
        conn = await connect_db()
        if not conn:
            raise HTTPException(status_code=500, detail="Database connection failed")
        
        rows = await conn.fetch("SELECT * FROM tracks")
        
        tracks = [dict(row) for row in rows]
        
        return {"tracks": tracks}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        await conn.close()
        

""" --------------- Track Counts --------------- """
    
@app.get("/counttracks")
async def get_tracks_count():
    try:
        conn = await connect_db()
        if not conn:
            raise HTTPException(status_code=500, detail="Database connection failed")
        
        # Query to get the count of rows in the tracks table
        result = await conn.fetchval("SELECT COUNT(*) FROM tracks")

        return {"track_count": result}

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        await conn.close()


""" --------------- All Data --------------- """

@app.get("/allsubmissions")
async def get_all_data():

    try:
        conn = await connect_db()
        if not conn:
            raise HTTPException(status_code=500, detail="Database connection failed")
        
        rows = await conn.fetch("SELECT * FROM data_submission")
        
        submissions = [dict(row) for row in rows]
        
        return {"submissions": submissions}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        await conn.close()
        
""" --------------- Data Counts --------------- """
        
@app.get("/countsubmission")
async def get_submission_count():
    try:
        conn = await connect_db()
        if not conn:
            raise HTTPException(status_code=500, detail="Database connection failed")
        
        # Query to get the count of rows in the tracks table
        result = await conn.fetchval("SELECT COUNT(*) FROM data_submission")

        return {"submission_count": result}

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        await conn.close()