from pydantic import BaseModel
from datetime import datetime
from typing import Optional

class TrackEntry(BaseModel):
    user_uuid: str
    latitude: float
    longitude: float
    datetime: str
    temperature: Optional[float] = None
    humidity: Optional[float] = None
    pressure: Optional[float] = None
    wind_speed: Optional[float] = None
