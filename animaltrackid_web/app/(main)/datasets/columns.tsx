"use client";

import { ColumnDef } from "@tanstack/react-table";
import { Button } from "@/components/ui/button";
import { MoreHorizontal } from "lucide-react";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import Image from "next/image";

export type Track = {
  id: number;
  user_uuid: string;
  species_name: string;
  image_url: string;
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
    accessorKey: "species_name",
    header: "Species Name",
  },
  {
    accessorKey: "image_url",
  header: "Image URL",
  cell: ({ row }) => {
    const imageUrl = row.getValue("image_url") as string;
    return <span className="text-blue-500 break-all">{imageUrl}</span>;
  },
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