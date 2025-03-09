import asyncpg
import os
from dotenv import load_dotenv

load_dotenv()

async def connect_db():
    try:
        conn = await asyncpg.connect(
            database=os.getenv("DB_NAME"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASSWORD"),
            host=os.getenv("DB_HOST"),
            port=os.getenv("DB_PORT"),
            ssl="require"
        )
        print("Successfully connected to PostgreSQL")
        return conn
    except Exception as e:
        print("Connection error:", e)
        return None
