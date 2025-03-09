"use client";

import { useEffect, useState } from "react";
import { DataTable } from "@/components/ui/data-table";
import { columns } from "./columns"; 

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
        const response = await fetch("/api/tracks");
        const data = await response.json();
        setTracks(data);
      } catch (error) {
        console.error("Error fetching tracks:", error);
      } finally {
        setLoading(false);
      }
    }

    fetchTracks();
  }, []);

  if (loading) return <p>Loading tracks...</p>;

  return (
    <div className="container mx-auto py-10">
      <h1 className="text-xl font-bold mb-4">Tracks</h1>
      <DataTable columns={columns} data={tracks} numberOfRows={5} />
    </div>
  );
}