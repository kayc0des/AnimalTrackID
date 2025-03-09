import { Skeleton } from "@nextui-org/react";
import { Spinner } from "@nextui-org/react";
const Loading = () => {
    return (
      <div  className="flex justify-center items-center h-[90vh]">
        <Spinner label="Loading..." color="danger" size="lg" />
      </div>
    );
}
 
export default Loading;