"use client";

import { ColumnDef } from "@tanstack/react-table";
import { Chip } from "@nextui-org/chip";
import { Button } from "@/components/ui/button";
import { useToast } from "@/components/ui/use-toast";
import { ToastAction } from "@/components/ui/toast";
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

export type Orders = {
  id: string;
  product: string;
  customerName: string;
  date: Date;
  status: "processing" | "completed" | "cancelled";
  destination: string;
};

export const columns: ColumnDef<Orders>[] = [
  {
    accessorKey: "id",
    header: "ID",
  },
  {
    accessorKey: "product",
    header: "Product",
  },
  {
    accessorKey: "customerName",
    header: "Customer Name",
  },
  {
    accessorKey: "date",
    header: "Ordered on",
    cell: ({ row }) => {
      const date = row.getValue("date") as Date;
      const formattedDate = date.toDateString();

      return formattedDate;
    },
  },
  {
    accessorKey: "status",
    header: "Status",
    cell: ({ row }) => {
      const status = row.getValue("status");
      const chipType =
        status == "completed" ? (
          <Chip
            endContent={<BadgeCheck size={18} />}
            variant="flat"
            color="success"
          >
            Completed
          </Chip>
        ) : status == "processing" ? (
          <Chip
            endContent={<CircleDashed size={18} />}
            variant="flat"
            color="warning"
          >
            Processing
          </Chip>
        ) : status == "cancelled" ? (
          <Chip
            endContent={<CircleX size={18} />}
            variant="flat"
            color="danger"
          >
            Cancelled
          </Chip>
        ) : null;

      return chipType;
    },
  },
  {
    header: "Actions",
    id: "actions",
    cell: ({ row }) => {
      const dataEntry = row.original;
      const { toast } = useToast();

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
              onClick={() => {
                navigator.clipboard.writeText(dataEntry.id);
                toast({
                  title: "Copied to clipboard",
                  description: "You copied this vendors ID to your clipboard",
                  action: <ToastAction altText="Cancel">Cancel</ToastAction>,
                });
              }}
            >
              Copy Order ID
            </DropdownMenuItem>
            <DropdownMenuSeparator />
            <DropdownMenuItem>View Order</DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      );
    },
  },
];
