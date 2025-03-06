'use client'

import { Card, CardContent, CardHeader } from "@/components/ui/card";
import {DateRangePicker} from "@nextui-org/date-picker";
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import data from "@/data/analytics";


const AnalyticsChart = () => {
  return (
    <div>
      <Card className="w-full mt-6 max-h-full h-[70vh] md:h-[65vh] rounded-3xl border-none">
        <CardHeader>
          <div className="flex flex-col md:flex-row md:items-center justify-between pt-2 pb-4">
            <div className="flex flex-col md:flex-row  md:items-center">
              <p className="text-3xl font-semibold pe-4">Statistics</p>
              <p className="hidden md:flex items-center pe-4">
                <span className="rounded-full block w-[15px] h-[6px] bg-green-600 mr-2">
                  &nbsp;
                </span>
                <span className="font-light">Vendors</span>
              </p>
              <p className="hidden md:flex items-center pe-4">
                <span className="rounded-full block w-[15px] h-[6px] bg-red-600 mr-2">
                  &nbsp;
                </span>
                <span className="font-light">Products Listed</span>
              </p>
              <p className="hidden md:flex items-center pe-4">
                <span className="rounded-full block w-[15px] h-[6px] bg-yellow-300 mr-2">
                  &nbsp;
                </span>
                <span className="font-light">Orders</span>
              </p>
            </div>
            {/* <DateRangePicker
              className="max-w-xs"
              label="Choose a timeframe"
              variant="bordered"
              visibleMonths={2}
            /> */}
          </div>
        </CardHeader>
        <CardContent>
          <div style={{ width: "100%", height: 550 }}>
            <ResponsiveContainer width="100%" height="100%">
              <LineChart
                width={500}
                height={300}
                data={data}
                margin={{
                  top: 5,
                  right: 30,
                  left: 20,
                  bottom: 5,
                }}
              >
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="month" />
                <YAxis />
                <Tooltip />
                <Legend className="block md:hidden" />
                <Line
                  type="monotone"
                  dataKey="products"
                  stroke="#dc2626"
                  fill="#dc262645"
                  activeDot={{ r: 8 }}
                />
                <Line
                  type="monotone"
                  dataKey="vendors"
                  stroke="#16a34a"
                  fill="#16a34a4f"
                />
                <Line
                  type="monotone"
                  dataKey="orders"
                  stroke="#fde047"
                  fill="#fddf4751"
                />
              </LineChart>
            </ResponsiveContainer>
          </div>
        </CardContent>
      </Card>
    </div>
  );
};

export default AnalyticsChart;
