import asyncpg
import os
from dotenv import load_dotenv

load_dotenv()

async def get_all_records():
    try:
        conn = await asyncpg.connect(
            database=os.getenv("DB_NAME"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASSWORD"),
            host=os.getenv("DB_HOST"),
            port=os.getenv("DB_PORT"),
            ssl="require"
        )
        
        rows = await conn.fetch("SELECT * FROM tracks")
        tracks = [dict(row) for row in rows]
        print(tracks)

        return {"tracks": tracks} 
    
    except Exception as e:
        print(f"Error: {str(e)}")
    finally:
        await conn.close()