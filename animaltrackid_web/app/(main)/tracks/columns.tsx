"use client";

import { ColumnDef } from "@tanstack/react-table";
import { Button } from "@/components/ui/button";
import { MoreHorizontal, ArrowUpDown } from "lucide-react";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

export type Track = {
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
};

export const columns: ColumnDef<Track>[] = [
  {
    accessorKey: "id",
    header: "ID",
  },
  {
    accessorKey: "user_uuid",
    header: "User UUID",
  },
  {
    accessorKey: "species",
    header: "Species",
  },
  {
    accessorKey: "latitude",
    header: "Latitude",
  },
  {
    accessorKey: "longitude",
    header: "Longitude",
  },
  {
    accessorKey: "datetime",
    header: "Date & Time",
    cell: ({ row }) => {
      const datetime = row.getValue("datetime") as string;
      const formattedDate = new Date(datetime).toLocaleString(); // Format the date
      return formattedDate;
    },
  },
  {
    accessorKey: "temperature",
    header: "Temperature (°C)",
  },
  {
    accessorKey: "pressure",
    header: "Pressure (hPa)",
  },
  {
    accessorKey: "humidity",
    header: "Humidity (%)",
  },
  {
    accessorKey: "wind_speed",
    header: "Wind Speed (m/s)",
  },
  {
    id: "actions",
    header: "Actions",
    cell: ({ row }) => {
      const track = row.original;

      return (
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button variant="ghost" className="h-8 w-8 p-0">
              <span className="sr-only">Open menu</span>
              <MoreHorizontal className="h-4 w-4" />
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="end">
            <DropdownMenuLabel>Actions</DropdownMenuLabel>
            <DropdownMenuItem
              onClick={() => navigator.clipboard.writeText(track.user_uuid)}
            >
              Copy User UUID
            </DropdownMenuItem>
            <DropdownMenuItem
              onClick={() => navigator.clipboard.writeText(track.id.toString())}
            >
              Copy Track ID
            </DropdownMenuItem>
            <DropdownMenuSeparator />
            <DropdownMenuItem>View Track Details</DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      );
    },
  },
];