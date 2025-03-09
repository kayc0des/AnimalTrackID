import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()

def create_tables():
    try:
        conn = psycopg2.connect(
            dbname=os.getenv("DB_NAME"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASSWORD"),
            host=os.getenv("DB_HOST"),
            port=os.getenv("DB_PORT"),
            sslmode="require"
        )
        cur = conn.cursor()

        cur.execute("""
            CREATE TABLE IF NOT EXISTS tracks (
                id SERIAL PRIMARY KEY,
                user_uuid VARCHAR(255),
                species VARCHAR(255),
                latitude FLOAT,
                longitude FLOAT,
                datetime VARCHAR(50),
                temperature FLOAT,
                pressure FLOAT,
                humidity FLOAT,
                wind_speed FLOAT
            );
        """)

        cur.execute("""
            CREATE TABLE IF NOT EXISTS data_submission (
                id SERIAL PRIMARY KEY,
                user_uuid VARCHAR(255),
                species_name VARCHAR(50),
                image_url TEXT  -- Link to the image storage
            );
        """)

        conn.commit()
        cur.close()
        conn.close()
        print("Tables created successfully.")

    except Exception as e:
        print("Error creating tables:", e)

if __name__ == "__main__":
    create_tables()