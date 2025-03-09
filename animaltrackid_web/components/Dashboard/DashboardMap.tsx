"use client";

import { Card, CardContent, CardHeader } from "@/components/ui/card";
import { MapContainer, TileLayer, Marker, Popup } from "react-leaflet";
import L from "leaflet";
import "leaflet/dist/leaflet.css";

// Example species data
const speciesData = [
  { id: 1, name: "Species A", lat: -1.2921, lng: 36.8219, color: "green" },
  { id: 2, name: "Species B", lat: -0.2921, lng: 36.7219, color: "red" },
  { id: 3, name: "Species C", lat: -1.0921, lng: 36.9219, color: "yellow" },
];

// Function to generate a custom map icon
const getCustomIcon = (color: string): L.DivIcon => {
  return L.divIcon({
    className: "",
    html: `<div style="background-color: ${color}; width: 15px; height: 15px; border-radius: 50%;"></div>`,
  });
};

const MapComponent = () => {
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
            center={[speciesData[0].lat, speciesData[0].lng]}
            zoom={5}
            style={{ width: "100%", height: "100%", borderRadius: "12px" }}
          >
            <TileLayer
              url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
            />
            {speciesData.map((species) => (
              <Marker
                key={species.id}
                position={[species.lat, species.lng]}
                icon={getCustomIcon(species.color)}
              >
                <Popup>{species.name}</Popup>
              </Marker>
            ))}
          </MapContainer>
        </div>
      </CardContent>
    </Card>
  );
};

export default MapComponent;
