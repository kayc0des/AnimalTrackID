"use client";

import Image from "next/image";
import Link from "next/link";
import NotificationsPopover from "./NotificationsPopover";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Search } from "lucide-react";
import Logo from "../public/images/site-logo.png"
import DashboardGreeting from "./Dashboard/DashboardGreeting";
import { usePathname } from "next/navigation";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import Breadcrumb from "./Breadcrumb";


const NavBar = () => {
    const pathname = usePathname();
    return (
      <div className="navbar sticky z-10 top-0 w-full ml-0 ps-6 md:ps-0 pt-3 flex justify-between items-center">
        <div className="pageTitle">
          {pathname == "/" ? (
            <div className="hidden md:block">
              <DashboardGreeting />
            </div>
          ) : (
            <div className="hidden md:block">
              <Breadcrumb
                title={
                  pathname.slice(1).charAt(0).toLocaleUpperCase() +
                  pathname.slice(2)
                }
              />
            </div>
          )}
          <div className="md:hidden block">
            <Image src={Logo} width={160} alt="site logo" />
          </div>
        </div>
        <div className="navbarCta flex flex-row items-center justify-end md:w-[60%]">
          <form action="" className="hidden  md:block">
            <div className="searchBar flex flex-row">
              <Search strokeWidth={1.2} />
              <input
                placeholder="Search..."
                type="search"
                className="w-[90%]"
                name=""
                id=""
              />
            </div>
          </form>

          <NotificationsPopover />

          <DropdownMenu>
            <DropdownMenuTrigger className="focus:outline-none">
              <Avatar>
                <AvatarImage src="" width={60} />
                <AvatarFallback>KB</AvatarFallback>
              </Avatar>
            </DropdownMenuTrigger>
            <DropdownMenuContent>
              <DropdownMenuLabel>My Account</DropdownMenuLabel>
              <DropdownMenuSeparator />
              <DropdownMenuItem>
                <Link href="/profile">Profile</Link>
              </DropdownMenuItem>
              <DropdownMenuItem>
                <Link href="/settings">Settings</Link>
              </DropdownMenuItem>
              <DropdownMenuItem>
                <Link href="/login">Logout</Link>
              </DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>
        </div>
      </div>
    );
}
 
export default NavBar;