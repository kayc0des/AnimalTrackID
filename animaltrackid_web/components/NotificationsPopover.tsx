import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import { BellRing, Check } from "lucide-react";
import { cn } from "@/lib/utils";
import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Switch } from "@/components/ui/switch";

const notifications = [
  {
    title: "Your call has been confirmed.",
    description: "1 hour ago",
  },
  {
    title: "You have a new message!",
    description: "1 hour ago",
  },
  {
    title: "Your subscription is expiring soon!",
    description: "2 hours ago",
  },
];

type CardProps = React.ComponentProps<typeof Card>;

const NotificationsPopover = ({ className, ...props }: CardProps) => {
  return (
    <div>
      <Popover>
        <PopoverTrigger>
          <div className="updates flex flex-row mr-4 items-center cursor-pointer">
            <BellRing strokeWidth={1.3} />
            <span className="ps-3 hidden md:block">Updates</span>
            <span className="updatesDot ml-3">&nbsp;</span>
          </div>
        </PopoverTrigger>
          <PopoverContent>
            Notifications will go hear
          </PopoverContent>
        
      </Popover>
    </div>
  );
};

export default NotificationsPopover;
