import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { DataTable } from "@/components/ui/data-table";
import { Payments, columns } from "./columns";

async function getData(): Promise<Payments[]> {
  return [
    {
      id: "7303083839jdkd",
      vendorId: "0387639xnks",
      amount: 409583,
      status: "processing",
      date: new Date("2024-04-24"),
    },
    {
      id: "7303083839jdkd",
      vendorId: "038393dmc",
      amount: 630893,
      status: "successful",
      date: new Date("2023-12-24"),
    },
    {
      id: "7303083839jdkd",
      vendorId: "0387639xnks",
      amount: 92738,
      status: "processing",
      date: new Date("2024-04-24"),
    },
    {
      id: "7303083839jdkd",
      vendorId: "038393dmc",
      amount: 3943939,
      status: "failed",
      date: new Date("2024-03-14"),
    },
    {
      id: "7303083839jdkd",
      vendorId: "038393dmc",
      amount: 388920,
      status: "successful",
      date: new Date("2024-02-29"),
    },
  ];
}

async function PaymentsPage() {
  const allPayments = await getData();
  const successfulPayments = allPayments.filter(
    (item) => item.status == "successful"
  );
  const processingPayments = allPayments.filter(
    (item) => item.status == "processing"
  );
  const failedPayments = allPayments.filter(
    (item) => item.status == "failed"
  );
  return (
    <div>
      <div>
        <Tabs defaultValue="allPayments" className="w-[100%]">
          <TabsList className="bg-transparent grid grid-cols-4 gap-5">
            <TabsTrigger
              value="allPayments"
              className="flex justify-between px-3 py-4 rounded-lg border text-base border-gray-200 tabTrigger"
            >
              <span>All Payments</span>
              <span>{allPayments.length}</span>
            </TabsTrigger>
            <TabsTrigger
              value="processing"
              className="flex justify-between px-3 py-4 rounded-lg border text-base border-gray-200 tabTrigger"
            >
              <span>Processing</span>
              <span>{processingPayments.length}</span>
            </TabsTrigger>
            <TabsTrigger
              value="successful"
              className="flex justify-between px-3 py-4 rounded-lg border text-base border-gray-200 tabTrigger"
            >
              <span>Successful Payments</span>
              <span>{successfulPayments.length}</span>
            </TabsTrigger>
            <TabsTrigger
              value="failed"
              className="flex justify-between px-3 py-4 rounded-lg border text-base border-gray-200 tabTrigger"
            >
              <span>Failed Payments</span>
              <span>{failedPayments.length}</span>
            </TabsTrigger>
          </TabsList>

          <TabsContent value="allPayments" className="mt-6">
            <DataTable columns={columns} data={allPayments} numberOfRows={10} />
          </TabsContent>

          <TabsContent value="processing" className="mt-6">
            <DataTable
              columns={columns}
              data={processingPayments}
              numberOfRows={10}
            />
          </TabsContent>
          <TabsContent value="successful" className="mt-6">
            <DataTable
              columns={columns}
              data={successfulPayments}
              numberOfRows={10}
            />
          </TabsContent>
          <TabsContent value="failed" className="mt-6">
            <DataTable
              columns={columns}
              data={failedPayments}
              numberOfRows={10}
            />
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}

export default PaymentsPage;
