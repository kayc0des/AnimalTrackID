import { DateRangePicker } from "@nextui-org/date-picker";
import VendorCard from "@/components/Dashboard/VendorCard";
import { Users, HandCoins } from "lucide-react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { DataTable } from "@/components/ui/data-table";
import { Buyers, columns } from "./columns";


async function getData(): Promise<Buyers[]> {
  // Fetch data from your API here.
  return [
    {
      id: "728ed52f",
      username: "ambejoshua23",
      status: "Suspended",
      town: "Buea",
      date: new Date("2022-03-19"),
      email: "ambe@example.com",
    },
    {
      id: "728ed52f",
      username: "lazarus67",
      status: "Approved",
      town: "Douala",
      date: new Date("2022-03-19"),
      email: "rus89@acme.com",
    },
    {
      id: "728ed52f",
      username: "chrismj22",
      status: "Pending",
      town: "Yaounde",
      date: new Date("2022-03-19"),
      email: "christopher@gmail.com",
    },
    {
      id: "728ed52f",
      username: "olivier90",
      status: "Pending",
      town: "Bamenda",
      date: new Date("2022-03-19"),
      email: "olivier88@yahoo.com",
    },
    {
      id: "728ed52f",
      username: "angelique78",
      status: "Approved",
      town: "Bertoua",
      date: new Date("2022-03-19"),
      email: "caitlynangel@hotmail.com",
    },
    {
      id: "728ed52f",
      username: "ambejoshua23",
      status: "Suspended",
      town: "Buea",
      date: new Date("2023-01-09"),
      email: "ambe@example.com",
    },
    {
      id: "728ed52f",
      username: "lazarus67",
      status: "Approved",
      town: "Douala",
      date: new Date("2023-12-19"),
      email: "rus89@acme.com",
    },
    {
      id: "728ed52f",
      username: "dianne",
      status: "Pending",
      town: "Yaounde",
      date: new Date("2019-05-19"),
      email: "dianne@gmail.com",
    },
    {
      id: "728ed52f",
      username: "guymann",
      status: "Pending",
      town: "Fundong",
      date: new Date("2022-12-19"),
      email: "guymano@yahoo.com",
    },
    {
      id: "728ed52f",
      username: "dominicement",
      status: "Approved",
      town: "Bertoua",
      date: new Date("2022-03-19"),
      email: "ementinho@hotmail.com",
    },
    {
      id: "728ed52f",
      username: "gideon223",
      status: "Suspended",
      town: "Buea",
      date: new Date("2020-02-11"),
      email: "GIDO55@example.com",
    },
    {
      id: "728ed52f",
      username: "caspain",
      status: "Approved",
      town: "Douala",
      date: new Date("2022-03-19"),
      email: "caspaino@acme.com",
    },
    {
      id: "728ed52f",
      username: "thomas93",
      status: "Pending",
      town: "Mbankomo",
      date: new Date("2022-03-19"),
      email: "christopher@gmail.com",
    },
    {
      id: "728ed52f",
      username: "malcolmx",
      status: "Approved",
      town: "Bafoussam",
      date: new Date("2023-03-24"),
      email: "malcolm02@yahoo.com",
    },
    {
      id: "728ed52f",
      username: "purpleson",
      status: "Approved",
      town: "Ngaoundere",
      date: new Date("2023-09-14"),
      email: "purpleson@hotmail.com",
    },
    {
      id: "728ed52f",
      username: "gilespos67",
      status: "Suspended",
      town: "Nkambe",
      date: new Date("2023-01-28"),
      email: "ambe@example.com",
    },
    {
      id: "728ed52f",
      username: "ravenclaw7",
      status: "Approved",
      town: "Douala",
      date: new Date("2021-11-04"),
      email: "ravenclaw7@acme.com",
    },
    {
      id: "728ed52f",
      username: "milestone45",
      status: "Pending",
      town: "Yaounde",
      date: new Date("2024-10-24"),
      email: "stonemiles@gmail.com",
    },
    {
      id: "728ed52f",
      username: "jacksonpot",
      status: "Pending",
      town: "Bamenda",
      date: new Date("2022-03-19"),
      email: "potboy@yahoo.com",
    },
    {
      id: "728ed52f",
      username: "occipitalroach",
      status: "Approved",
      town: "Bertoua",
      date: new Date("2022-03-19"),
      email: "occipitalroach@hotmail.com",
    },
  ];
}
async function BuyersPage() {
    const allBuyers = await getData();
    const approvedBuyers = allBuyers.filter(
      (item) => item.status == "Approved"
    );
    const suspendedBuyers = allBuyers.filter(
      (item) => item.status == "Suspended"
    );
    return (
      <div>
        <div className="flex justify-end pb-5">
          <DateRangePicker
            label="Chose a timeframe"
            variant="bordered"
            className="max-w-xs"
          />
        </div>

        <div className="grid grid-cols-1 md:grid-cols-5 gap-8 mb-6">
          <div className="md:col-span-3">
            <VendorCard
              title="Total Buyers"
              percentage={6}
              amount={100577}
              chartKey="vendors"
              icon={<Users color="#ef0000" />}
            />
          </div>
          <div className="md:col-span-2">
            <VendorCard
              title="Money Spent"
              percentage={15}
              chartKey="orders"
              amount={62008394}
              icon={<HandCoins color="#ef0000" />}
            />
          </div>
        </div>

        <div>
          <Tabs defaultValue="allBuyers" className="w-[100%]">
            <TabsList className="bg-transparent grid grid-cols-3 gap-5">
              <TabsTrigger
                value="allBuyers"
                className="flex justify-between px-3 py-4 rounded-lg border text-base border-gray-200 tabTrigger"
              >
                <span>All Buyers</span>
                <span>{allBuyers.length}</span>
              </TabsTrigger>
              <TabsTrigger
                value="approvedBuyers"
                className="flex justify-between px-3 py-4 rounded-lg border text-base border-gray-200 tabTrigger"
              >
                <span>Approved Buyers</span>
                <span>{approvedBuyers.length}</span>
              </TabsTrigger>
              <TabsTrigger
                value="suspendedBuyers"
                className="flex justify-between px-3 py-4 rounded-lg border text-base border-gray-200 tabTrigger"
              >
                <span>Suspended Buyers</span>
                <span>{suspendedBuyers.length}</span>
              </TabsTrigger>
            </TabsList>

            <TabsContent value="allBuyers" className="mt-6">
              <DataTable columns={columns} data={allBuyers} numberOfRows={5} />
            </TabsContent>

            <TabsContent value="approvedBuyers" className="mt-6">
              <DataTable columns={columns} data={approvedBuyers} numberOfRows={5} />
            </TabsContent>
            <TabsContent value="suspendedBuyers" className="mt-6">
              <DataTable columns={columns} data={suspendedBuyers} numberOfRows={5} />
            </TabsContent>
          </Tabs>
        </div>
      </div>
    );
}
 
export default BuyersPage;