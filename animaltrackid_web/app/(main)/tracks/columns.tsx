"use client";

import { ColumnDef } from "@tanstack/react-table";
import { Chip } from "@nextui-org/chip";
import { Button } from "@/components/ui/button";
import {
  BadgeCheck,
  CircleDashed,
  CircleX,
  MoreHorizontal,
  ArrowUpDown,
} from "lucide-react";

import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

export type Buyers = {
  id: string;
  username: string;
  town: string;
  status: "Pending" | "Approved" | "Suspended";
  email: string;
  date: Date;
};

export const columns: ColumnDef<Buyers>[] = [
  {
    accessorKey: "username",
    header: "User Name",
  },
  {
    accessorKey: "email",
    header: ({ column }) => {
      return (
        <Button
          variant="ghost"
          onClick={() => column.toggleSorting(column.getIsSorted() === "asc")}
        >
          Email
          <ArrowUpDown className="ml-2 h-4 w-4" />
        </Button>
      );
    },
  },
  {
    accessorKey: "town",
    header: "Town",
  },
  {
    accessorKey: "status",
    header: "Status",
    cell: ({ row }) => {
      const status = row.getValue("status");
      const chipType =
        status == "Approved" ? (
          <Chip
            endContent={<BadgeCheck size={18} />}
            variant="flat"
            color="success"
          >
            Approved
          </Chip>
        ) : status == "Pending" ? (
          <Chip
            endContent={<CircleDashed size={18} />}
            variant="flat"
            color="warning"
          >
            Pending
          </Chip>
        ) : status == "Suspended" ? (
          <Chip
            endContent={<CircleX size={18} />}
            variant="flat"
            color="danger"
          >
            Suspended
          </Chip>
        ) : null;

      return chipType;
    },
  },
  {
    accessorKey: "date",
    header: "Date Joined",
    cell: ({ row }) => {
      const date = row.getValue("date") as Date;
      const formattedDate = date.toDateString();

      return formattedDate;
    },
  },
  {
    header: "Actions",
    id: "actions",
    cell: ({ row }) => {
      const dataEntry = row.original;

      return (
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button variant="ghost" className="h-8 w-8 p-0 text-right">
              <span className="sr-only">Open menu</span>
              <MoreHorizontal className="h-4 w-4" />
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="end">
            <DropdownMenuLabel>Actions</DropdownMenuLabel>
            <DropdownMenuItem
              onClick={() => navigator.clipboard.writeText(dataEntry.id)}
            >
              Copy Vendor ID
            </DropdownMenuItem>
            <DropdownMenuSeparator />
            <DropdownMenuItem>View Vendor</DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      );
    },
  },
];
