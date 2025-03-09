"use client";

import { useEffect, useState } from "react";
import { DataTable } from "@/components/ui/data-table";
import { columns } from "./columns"; // Import the columns definition
import { Button } from "@/components/ui/button";

interface User {
  id: string;
  email: string;
  provider: string;
  createdAt: string;
}

export default function Page() {
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function fetchUsers() {
      try {
        const response = await fetch("/api/users");
        const data = await response.json();
        setUsers(data);
      } catch (error) {
        console.error("Error fetching users:", error);
      } finally {
        setLoading(false);
      }
    }

    fetchUsers();
  }, []);

  if (loading) return <p>Loading users...</p>;

  return (
    <div className="container mx-auto py-10">
      <h1 className="text-xl font-bold mb-4">Trackers</h1>
      <DataTable columns={columns} data={users} numberOfRows={5} />
    </div>
  );
}