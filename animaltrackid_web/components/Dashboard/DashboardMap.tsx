"use client";

import { Card, CardContent, CardHeader } from "@/components/ui/card";
import { MapContainer, TileLayer, Marker, Popup } from "react-leaflet";
import L from "leaflet";
import "leaflet/dist/leaflet.css";

// Define species colors
const speciesColors: { [key: string]: string } = {
  Lion: "red",
  Horse: "blue",
  Elephant: "green",
  Muledeer: "orange",
  Turkey: "purple",
  Otter: "yellow",
};

// Function to generate a custom map icon
const getCustomIcon = (color: string): L.DivIcon => {
  return L.divIcon({
    className: "",
    html: `<div style="background-color: ${color}; width: 15px; height: 15px; border-radius: 50%;"></div>`,
  });
};

interface SpeciesData {
  [key: string]: { latitude: number; longitude: number }[];
}

interface MapComponentProps {
  speciesData: SpeciesData;
}

const MapComponent = ({ speciesData }: MapComponentProps) => {
  if (Object.keys(speciesData).length === 0) {
    return <p>Loading map data...</p>;
  }

  return (
    <Card className="w-full mt-6 max-h-full h-[70vh] md:h-[65vh] rounded-3xl border-none">
      <CardHeader>
        <div className="flex flex-col md:flex-row md:items-center justify-between pt-2 pb-4">
          <p className="text-3xl font-semibold">Track Sightings</p>
        </div>
      </CardHeader>
      <CardContent>
        <div className="w-full h-[550px]">
          <MapContainer
            center={[37.785834, -122.406417]} // Default center (can be adjusted)
            zoom={5}
            style={{ width: "100%", height: "100%", borderRadius: "12px" }}
          >
            <TileLayer
              url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
            />
            {Object.entries(speciesData).map(([species, locations]) =>
              locations.map((location, index) => (
                <Marker
                  key={`${species}-${index}`}
                  position={[location.latitude, location.longitude]}
                  icon={getCustomIcon(speciesColors[species] || "gray")}
                >
                  <Popup>{species}</Popup>
                </Marker>
              ))
            )}
          </MapContainer>
        </div>
      </CardContent>
    </Card>
  );
};

export default MapComponent;