import Image from "next/image";
import { ChevronsUp, ChevronsDown, Users, Footprints, Boxes } from "lucide-react";
import DashboardCard from "@/components/Dashboard/DashboardCard";
import MapComponent from "@/components/Dashboard/map";
import DashboardGreeting from "@/components/Dashboard/DashboardGreeting";

export default function Home() {
  return (
    <div>
      <div className="block md:hidden pb-4">
        <DashboardGreeting />
      </div>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-8 w-[100%]">
        <DashboardCard
          title="Total Tracks Found"
          count={3000}
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
          count={998}
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