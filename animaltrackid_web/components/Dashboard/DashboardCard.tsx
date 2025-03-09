import {
  Card,
  CardContent,
} from "@/components/ui/card";
import { LucideIcon } from "lucide-react";
interface DashboardCardProps {
  title: string;
  percentage: number;
  count: number;
  icon: React.ReactElement<LucideIcon>;
  changeicon: React.ReactElement<LucideIcon>;
}

const DashboardCard = ({title, percentage, count, icon, changeicon}: DashboardCardProps) => {
  return (
    <>
      <Card className="pt-8 pb-4 rounded-3xl border-none">
        <CardContent className="flex items-center justify-between">
          <div>
            <p className="text-xl pb-3">{title}</p>
            <p className="flex items-center pb-3">
              {changeicon}
              <span className="text-lg ps-2">{percentage}%</span>
            </p>
            <p className="text-3xl font-semibold pt-2">
              {count.toLocaleString()}
            </p>
          </div>
          {icon}
        </CardContent>
      </Card>
    </>
  );
};

export default DashboardCard;
