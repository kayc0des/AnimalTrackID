import { NextResponse } from "next/server";
import { Pool } from "pg";
import { readFileSync } from "fs";
import path from "path";

// Read the CA certificate
const caCertPath = path.join(process.cwd(), "api/tracks/ca.pem");
const caCert = readFileSync(caCertPath).toString();

// PostgreSQL connection pool with SSL
const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: parseInt(process.env.DB_PORT || "5432"),
  ssl: {
    rejectUnauthorized: true, // Verify the server's certificate
    ca: caCert, // Provide the CA certificate
  },
});

export async function GET() {
  try {
    const client = await pool.connect();
    const result = await client.query("SELECT * FROM tracks");
    const tracks = result.rows;
    client.release();

    return NextResponse.json(tracks);
  } catch (error) {
    console.error("Error fetching tracks:", error);
    return NextResponse.json(
      { error: "Failed to fetch tracks" },
      { status: 500 }
    );
  }
}