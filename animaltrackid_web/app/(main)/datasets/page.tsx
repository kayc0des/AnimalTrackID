"use client";

import { useEffect, useState } from "react";
import { DataTable } from "@/components/ui/data-table";
import { columns } from "./columns"; // Import the columns definition

export interface Submission {
  id: number;
  user_uuid: string;
  species_name: string;
  image_url: string;
}

export default function Page() {
  const [submissions, setSubmissions] = useState<Submission[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function fetchSubmissions() {
      try {
        const response = await fetch("http://localhost:8000/allsubmissions");
        const data = await response.json();
        setSubmissions(data.submissions);
      } catch (error) {
        console.error("Error fetching submissions:", error);
      } finally {
        setLoading(false);
      }
    }

    fetchSubmissions();
  }, []);

  if (loading) return <p>Loading submissions...</p>;

  return (
    <div className="container mx-auto py-10">
      <DataTable columns={columns} data={submissions} numberOfRows={5}/>
    </div>
  );
}