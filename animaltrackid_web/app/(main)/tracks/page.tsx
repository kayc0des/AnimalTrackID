"use client";

import { useEffect, useState } from "react";
import { DataTable } from "@/components/ui/data-table";
import { columns } from "./columns";
import { Button } from "@/components/ui/button"; // Import the Button component

export interface Track {
  id: number;
  user_uuid: string;
  species: string;
  latitude: number;
  longitude: number;
  datetime: string;
  temperature: number;
  pressure: number;
  humidity: number;
  wind_speed: number;
}

export default function Page() {
  const [tracks, setTracks] = useState<Track[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function fetchTracks() {
      try {
        const response = await fetch("http://localhost:8000/alltracks");
        const data = await response.json();
        setTracks(data.tracks); // Extract the "tracks" array from the response
      } catch (error) {
        console.error("Error fetching tracks:", error);
      } finally {
        setLoading(false);
      }
    }

    fetchTracks();
  }, []);

  // Function to handle CSV download
  const handleDownloadCSV = () => {
    window.location.href = "http://localhost:8000/download-tracks-csv";
  };

  if (loading) return <p>Loading tracks...</p>;

  return (
    <div className="container mx-auto py-10">
      {/* Add the Download CSV button */}
      <div className="mb-4">
        <Button onClick={handleDownloadCSV}>Download CSV</Button>
      </div>

      {/* Render the DataTable */}
      <DataTable columns={columns} data={tracks} numberOfRows={5} />
    </div>
  );
}