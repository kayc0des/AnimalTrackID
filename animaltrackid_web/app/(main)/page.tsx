"use client";

import { useEffect, useState } from "react";
import Image from "next/image";
import { ChevronsUp, ChevronsDown, Users, Footprints, Boxes } from "lucide-react";
import DashboardCard from "@/components/Dashboard/DashboardCard";
import MapComponent from "@/components/Dashboard/DashboardMap";
import DashboardGreeting from "@/components/Dashboard/DashboardGreeting";

export default function Home() {
  const [submissionCount, setSubmissionCount] = useState<number | null>(null);
  const [trackCount, setTrackCount] = useState<number | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function fetchCounts() {
      try {
        // Fetch submission count
        const submissionResponse = await fetch("http://localhost:8000/countsubmission");
        const submissionData = await submissionResponse.json();
        setSubmissionCount(submissionData.submission_count);

        // Fetch track count
        const trackResponse = await fetch("http://localhost:8000/counttracks");
        const trackData = await trackResponse.json();
        setTrackCount(trackData.track_count);
      } catch (error) {
        console.error("Error fetching counts:", error);
      } finally {
        setLoading(false);
      }
    }

    fetchCounts();
  }, []);

  if (loading) {
    return <p>Loading dashboard data...</p>;
  }

  return (
    <div>
      <div className="block md:hidden pb-4">
        <DashboardGreeting />
      </div>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-8 w-[100%]">
        <DashboardCard
          title="Total Tracks Found"
          count={trackCount || 0} // Fallback to 0 if trackCount is null
          percentage={3.14}
          icon={
            <div className="cardIcon bg-successGreen rounded-full p-6">
              <Footprints strokeWidth={1.2} size={24} />
            </div>
          }
          changeicon={
            <ChevronsUp color="#219653" strokeWidth={1.2} size={24} />
          }
        />
        <DashboardCard
          title="Total Data Submitted"
          count={submissionCount || 0} // Fallback to 0 if submissionCount is null
          percentage={2.14}
          icon={
            <div className="cardIcon bg-yellowLight rounded-full p-6">
              <Boxes strokeWidth={1.2} size={24} />
            </div>
          }
          changeicon={
            <ChevronsUp color="#219653" strokeWidth={1.2} size={24} />
          }
        />
        <DashboardCard
          title="Total Users"
          count={20}
          percentage={0.63}
          icon={
            <div className="cardIcon bg-successGreen rounded-full p-6">
              <Users strokeWidth={1.2} size={24} />
            </div>
          }
          changeicon={
            <ChevronsDown color="#ff0000" strokeWidth={1.2} size={24} />
          }
        />
      </div>
      <div className="h-[70vh]">
        <MapComponent />
      </div>
    </div>
  );
}