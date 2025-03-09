"use client";

import NavBar from "@/components/NavBar";
import Sidebar from "@/components/Sidebar";
import { MouseEvent, Suspense, useState } from "react";
import Loading from "../loading";
import { cn } from "@/lib/utils";


const DashboardLayout = ({ children }: { children: React.ReactNode }) => {
  const [isHidden, setIsHidden] = useState(false)
  const menuToggle = () => {
    setIsHidden(!isHidden)
  }
  return (
    <>
      <div
        className={cn(
          "hidden md:block h-[100vh] w-[18%] z-10	box-border transition-all duration-1000 bg-white fixed top-0",
          isHidden && "transition-all w-[5%] duration-1000"
        )}
      >
        <Sidebar handleClick={menuToggle} menuHide={isHidden} />
      </div>
      <div
        className={cn(
          "w-full md:w-[80%] transition-all duration-1000 md:ml-[20%] px-6 md:px-0 md:pe-6",
          isHidden &&
            "transition-all md:w-[95%] duration-1000 md:ml-[5%] md:px-6"
        )}
      >
        <NavBar />
        <Suspense fallback={<Loading />}>
          <div className="w-full pt-8">{children}</div>
        </Suspense>
      </div>
    </>
  );
};

export default DashboardLayout;
