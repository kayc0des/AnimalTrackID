"use client";

import { Card, CardHeader, CardBody } from "@nextui-org/card";
import {
  AreaChart,
  Area,
  Tooltip,
  ResponsiveContainer,
} from "recharts";
import { Chip } from "@nextui-org/react";
import data from "@/data/analytics";
import { LucideIcon } from "lucide-react";

interface VendorCardProps {
  title: string;
  percentage: number;
  amount: number;
  chartKey: string;
  icon: React.ReactElement<LucideIcon>;
}

const VendorCard = ({title, percentage, amount, icon, chartKey}: VendorCardProps) => {
  return (
    <div>
      <Card shadow="sm" className="p-0">
        <CardHeader className="flex justify-between items-center pb-5">
          <div className="flex items-center">
            <span className="p-4 mr-3 border border-gray-300 rounded-lg">
              {icon}
            </span>
            <p className="text-gray-400">{title}</p>
          </div>
          <Chip
            className="border border-green-600 px-3"
            color="success"
            radius="md"
            size="lg"
            variant="flat"
          >
            {percentage}%
          </Chip>
        </CardHeader>
        <CardBody>
          <p className="text-3xl font-semibold pb-2">
            {title == "Revenue Generated" || title == "Money Spent" ? `XAF ${amount.toLocaleString()}` : amount.toLocaleString()}
          </p>
          <div style={{ width: "100%", height: 100 }}>
            <ResponsiveContainer width="100%" height="100%">
              <AreaChart
                width={500}
                height={400}
                data={data}
                margin={{
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: 0,
                }}
              >
                <Tooltip />
                <Area
                  type="monotone"
                  dataKey={chartKey}
                  stroke="#238D51"
                  fill="#d4f5e276"
                />
              </AreaChart>
            </ResponsiveContainer>
          </div>
          <div className="flex justify-between items-center pt-5">
            <p>24 June 2023</p>
            <p>24 August 2023</p>
          </div>
        </CardBody>
      </Card>
    </div>
  );
};

export default VendorCard;
