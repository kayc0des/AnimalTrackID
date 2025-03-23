"use client";

import { useEffect, useState } from "react";
import dynamic from "next/dynamic";

// Dynamically import MapComponent with SSR disabled
const MapComponent = dynamic(() => import("@/components/Dashboard/PredictionMap"), {
  ssr: false,
});

interface LionData {
  key: string;
  latitude: number;
  longitude: number;
}

interface Prediction {
  latitude: number;
  longitude: number;
}

export default function LionPage() {
  const [lionData, setLionData] = useState<LionData[]>([]);
  const [loading, setLoading] = useState(true);
  const [file, setFile] = useState<File | null>(null);
  const [predictions, setPredictions] = useState<Prediction[]>([]); // State for new predictions

  useEffect(() => {
    async function fetchLionData() {
      try {
        // Fetch lion data
        const response = await fetch("http://localhost:8000/lion");
        const data = await response.json();
        setLionData(data);
      } catch (error) {
        console.error("Error fetching lion data:", error);
      } finally {
        setLoading(false);
      }
    }

    fetchLionData();
  }, []);

  // Handle file upload
  const handleFileChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    if (event.target.files && event.target.files[0]) {
      setFile(event.target.files[0]);
    }
  };

  // Handle prediction
  const handlePredict = async () => {
    if (!file) {
      alert("Please upload a CSV file first.");
      return;
    }

    const formData = new FormData();
    formData.append("file", file);

    try {
      const response = await fetch("http://localhost:8000/lstmpredict", {
        method: "POST",
        body: formData,
      });

      if (!response.ok) {
        throw new Error("Failed to predict next month's data.");
      }

      const result = await response.json();
      console.log("Prediction result:", result);
      setPredictions(result.predictions); // Store the new predictions
    } catch (error) {
      console.error("Error predicting next month's data:", error);
      alert("Error predicting next month's data. Please try again.");
    }
  };

  if (loading) {
    return <p>Loading lion data...</p>;
  }

  return (
    <div className="container mx-auto py-10">
      <h1 className="text-3xl font-bold mb-6">Aug-Jan 2025 Tracks</h1>

      {/* Upload CSV File and Predict Button */}
      <div className="mb-6">
        <div className="flex items-center gap-4">
          <input
            type="file"
            accept=".csv"
            onChange={handleFileChange}
            className="border p-2 rounded"
          />
          <button
            onClick={handlePredict}
            style={{ backgroundColor: "#003728" }} // Custom button color
            className="text-white px-4 py-2 rounded hover:bg-opacity-90 transition-all"
          >
            Predict Next Month
          </button>
        </div>
      </div>

      {/* Map Component */}
      <div className="h-[70vh]">
        <MapComponent
          speciesData={{ Lion: lionData }} // Original lion data (red dots)
          predictions={predictions} // New predictions (blue dots)
        />
      </div>
    </div>
  );
}