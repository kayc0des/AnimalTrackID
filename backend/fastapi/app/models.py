from pydantic import BaseModel

class PredictionResponse(BaseModel):
    species_name: str
    latitude: float
    longitude: float
    datetime: str
    temperature: float
    humidity: float
    pressure: float
    windspeed: float