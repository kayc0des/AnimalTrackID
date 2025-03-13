import os
import requests
from dotenv import load_dotenv
import json

load_dotenv()  # Load environment variables from .env file

class WeatherService:
    def __init__(self):
        self.api_key = os.getenv("WEATHER_API_KEY")  # Get API key from environment
        self.base_url = "https://api.openweathermap.org/data/3.0/onecall"

    def get_weather(self, latitude: float, longitude: float) -> dict:
        """Fetches weather data for the given latitude and longitude."""
        url = f"{self.base_url}?lat={latitude}&lon={longitude}&appid={self.api_key}&units=metric"

        try:
            response = requests.get(url)
            if response.status_code == 200:
                return response.json()
            else:
                raise Exception(f"Failed to fetch weather data: {response.status_code}")
        except Exception as e:
            raise Exception(f"Failed to fetch weather data: {e}")
