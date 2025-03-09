'use client';

import Link from "next/link";
import Image from "next/image";
import logo from "../public/images/site-logo.png";
import logoSmall from "@/public/images/logo-2.png"
import { cn } from "@/lib/utils";
import { usePathname } from "next/navigation";
import { useState, useEffect } from "react";
import {
  ArrowLeft,
  LayoutDashboard,
  Users,
  Boxes,
  Bot,
  Footprints,
  Settings,
  LogOut,
  ArrowRight,
} from "lucide-react";


type SideBarProps = {
  handleClick: (event: React.MouseEvent<HTMLButtonElement>) => void; 
  menuHide: boolean;
}

const Sidebar = ({handleClick, menuHide}: SideBarProps) => {
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    setTimeout(() => {
      setIsLoading(false);
    }, 1000); 
  }, []);

   const handleNavigation = () => {
     setIsLoading(true);
   };

  const NavLinks = [
    {
      name: "Dashboard",
      path: "/",
      icon: <LayoutDashboard strokeWidth="1.3" />,
    },
    {
      name: "Tracks",
      path: "/tracks",
      icon: <Footprints strokeWidth="1.3" />,
    },
    {
      name: "RL Agent Prediction",
      path: "/rl",
      icon: <Bot strokeWidth="1.3" />,
    },
    {
      name: "Data Submissions",
      path: "/datasets",
      icon: <Boxes strokeWidth="1.3" />,
    },
    {
      name: "Users",
      path: "/users",
      icon: <Users strokeWidth="1.3" />,
    },
    {
      name: "Settings",
      path: "/settings",
      icon: <Settings strokeWidth="1.3" />,
    },
  ];

  const pathname = usePathname();

  return (
    <div className="sidebar">
      <div className="flex justify-between items-center mt-4 ps-4">
        <div className={cn("logo")}>
          {menuHide ? (
            <Image src={logoSmall} width={50} alt="AnimalTrackID Logo" />
          ) : (
            <Image src={logo} width={150} alt="AnimalTrackID Logo" />
          )}
        </div>
        <button
          className={cn(
            "sidebarToggle pe-0",
            menuHide && "sidebarToggleHidden"
          )}
          onClick={handleClick}
        >
          {menuHide ? <ArrowRight size={24} /> : <ArrowLeft size={30} />}
        </button>
      </div>

      <div className="sidebarLinks mt-5 pt-5 px-4">
        {NavLinks.map((link) => {
          const isActive = pathname === link.path;
          return (
            <Link href={link.path} key={NavLinks.indexOf(link)} prefetch>
              <div
                className={cn(
                  "linkItem p-3 my-3 rounded-full flex justify-between items-center transition-all duration-300 hover:bg-[#EFEFEF]",
                  isActive && "activeLink hover:bg-[#EF0000]"
                )}
              >
                <div className="flex">
                  {link.icon}
                  <p className={cn("ps-3", menuHide && "hidden ps-0")}>
                    {link.name}
                  </p>
                </div>
                <span
                  className={cn(
                    "block w-[.5rem] h-[.5rem] bg-white rounded-full"
                  )}
                ></span>
              </div>
            </Link>
          );
        })}

        <div className="absolute bottom-4">
          <Link href="/login" className="">
            <div className="linkItem p-3 my-3 rounded-full flex justify-between items-center">
              <div className="flex">
                <LogOut strokeWidth={1.5} />
                <p className={cn("ps-3", menuHide && "hidden ps-0")}>Logout</p>
              </div>
              <span className="block w-[10px] h-[10px] bg-white rounded-full"></span>
            </div>
          </Link>
          <p className={cn("copyrightText mx-2 pt-2", menuHide && "hidden")}>
            Copyrights 2025. Kayc0des. All rights reserved.
          </p>
        </div>
      </div>
    </div>
  );
};

export default Sidebar;
