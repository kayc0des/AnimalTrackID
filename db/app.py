from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from datetime import datetime
from dotenv import load_dotenv
from connection import connect_db

load_dotenv()

app = FastAPI()

class TrackEntry(BaseModel):
    user_uuid: str
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
            INSERT INTO tracks (user_uuid, latitude, longitude, datetime, temperature, pressure, humidity, wind_speed)
            VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
        """, entry.user_uuid, entry.latitude, entry.longitude, entry.datetime, entry.temperature, entry.pressure, entry.humidity, entry.wind_speed)
        
        return {"message": "Track added successfully!"}

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {e}")
    finally:
        await conn.close()
