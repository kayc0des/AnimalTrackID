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
import { date } from "zod";

export type Payments = {
  id: string;
  vendorId: string;
  amount: number;
  status: "successful" | "failed" | "processing";
  date: Date;
};

export const columns: ColumnDef<Payments>[] = [
  {
    accessorKey: "id",
    header: "Transaction ID",
  },
  {
    accessorKey: "vendorId",
    header: "Vendor ID",
  },
  {
    accessorKey: "amount",
    header: "Amount",
    cell: ({ row }) => {
      const amount = row.getValue("amount") as Number;
      const formattedAmount = `XAF ${amount.toLocaleString()}`;
      return formattedAmount;
    },
  },
  {
    accessorKey: "date",
    header: "Date",
    cell: ({ row }) => {
        const date = row.getValue("date") as Date;
        const formattedDate = date.toDateString();

        return formattedDate;
    }
  },
  {
    accessorKey: "status",
    header: "Status",
    cell: ({ row }) => {
      const status = row.getValue("status");
      const chipType =
        status == "successful" ? (
          <Chip
            endContent={<BadgeCheck size={18} />}
            variant="flat"
            color="success"
          >
            Successful
          </Chip>
        ) : status == "processing" ? (
          <Chip
            endContent={<CircleDashed size={18} />}
            variant="flat"
            color="warning"
          >
            Processing
          </Chip>
        ) : status == "failed" ? (
          <Chip
            endContent={<CircleX size={18} />}
            variant="flat"
            color="danger"
          >
            Failed
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
              Copy Transaction ID
            </DropdownMenuItem>
            <DropdownMenuSeparator />
            <DropdownMenuItem>View Transaction</DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      );
    },
  },
];
