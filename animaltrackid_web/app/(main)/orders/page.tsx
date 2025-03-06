import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { DataTable } from "@/components/ui/data-table";
import { Orders, columns } from "./columns";

async function getData(): Promise<Orders[]> {
  return [
    {
      id: "ocnif7lf8i-cj",
      product: "Skateboard",
      customerName: "Brandon Damue",
      status: "completed",
      destination: "Mundemba",
      date: new Date("2022-03-19"),
    },
    {
      id: "ocnpdd4vet-cj",
      product: "Amiri Court Hi Sneakers",
      customerName: "James Hess",
      status: "processing",
      destination: "Buea",
      date: new Date("2024-04-14"),
    },
    {
      id: "ocn2czb14m-cj",
      product: "Alexander McQueen Oversized Sneakers",
      customerName: "Mathieu Gatway",
      status: "cancelled",
      destination: "Bamenda",
      date: new Date("2024-05-14"),
    },
    {
      id: "ocn2czb14m-cj",
      product: "Alexander McQueen Oversized Sneakers",
      customerName: "Mathieu Gatway",
      status: "cancelled",
      destination: "Bafoussam",
      date: new Date("2024-06-24"),
    },
    {
      id: "ocnec8kiyd-cj",
      product: "iPhone Charger USB-c",
      customerName: "Julio Marty",
      status: "completed",
      destination: "Bafoussam",
      date: new Date("2024-06-24"),
    },
    {
      id: "ocnec8kiyd-cj",
      product: "Apple Airpods Pro 2",
      customerName: "Paul Ndamba",
      status: "completed",
      destination: "Douala",
      date: new Date("2024-06-24"),
    },
    {
      id: "ocns51ugmm-cj",
      product: "Apple Airpods Pro 2",
      customerName: "Paul Ndamba",
      status: "completed",
      destination: "Douala",
      date: new Date("2024-06-24"),
    },
    {
      id: "ocnec8kiyd-cj",
      product: "Apple Airpods Pro 2",
      customerName: "Paul Ndamba",
      status: "processing",
      destination: "Douala",
      date: new Date("2024-06-24"),
    },
    {
      id: "ocns51ugmm-cj",
      product: "Zara Palm slippers",
      customerName: "Nathaniel Ngwa",
      status: "cancelled",
      destination: "Douala",
      date: new Date("2024-02-10"),
    },
  ];
}

async function OrdersPage() {
  const allOrders = await getData();
  const completedOrders = allOrders.filter(
    (item) => item.status == "completed"
  );
  const processingOrders = allOrders.filter(
    (item) => item.status == "processing"
  );
  const cancelledOrders = allOrders.filter(
    (item) => item.status == "cancelled"
  );
  return (
    <div>
      <div>
        <Tabs defaultValue="allOrders" className="w-[100%]">
          <TabsList className="bg-transparent grid grid-cols-4 gap-5">
            <TabsTrigger
              value="allOrders"
              className="flex justify-between px-3 py-4 rounded-lg border text-base border-gray-200 tabTrigger"
            >
              <span>All Orders</span>
              <span>{allOrders.length}</span>
            </TabsTrigger>
            <TabsTrigger
              value="processing"
              className="flex justify-between px-3 py-4 rounded-lg border text-base border-gray-200 tabTrigger"
            >
              <span>Being Processed</span>
              <span>{processingOrders.length}</span>
            </TabsTrigger>
            <TabsTrigger
              value="completed"
              className="flex justify-between px-3 py-4 rounded-lg border text-base border-gray-200 tabTrigger"
            >
              <span>Completed</span>
              <span>{completedOrders.length}</span>
            </TabsTrigger>
            <TabsTrigger
              value="cancelled"
              className="flex justify-between px-3 py-4 rounded-lg border text-base border-gray-200 tabTrigger"
            >
              <span>Cancelled</span>
              <span>{cancelledOrders.length}</span>
            </TabsTrigger>
          </TabsList>

          <TabsContent value="allOrders" className="mt-6">
            <DataTable columns={columns} data={allOrders} numberOfRows={10} />
          </TabsContent>

          <TabsContent value="processing" className="mt-6">
            <DataTable
              columns={columns}
              data={processingOrders}
              numberOfRows={10}
            />
          </TabsContent>
          <TabsContent value="completed" className="mt-6">
            <DataTable
              columns={columns}
              data={completedOrders}
              numberOfRows={10}
            />
          </TabsContent>
          <TabsContent value="cancelled" className="mt-6">
            <DataTable
              columns={columns}
              data={cancelledOrders}
              numberOfRows={10}
            />
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}

export default OrdersPage;
