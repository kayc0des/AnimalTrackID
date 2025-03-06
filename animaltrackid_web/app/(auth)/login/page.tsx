"use client";

import Image from "next/image";
import logo from "@/public/images/site-logo.png";

import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { z } from "zod";

import { Button } from "@/components/ui/button";
import {
  Form,
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";

const formSchema = z.object({
  username: z
    .string()
    .min(4, { message: "Username must be 4 or more characters long" })
    .max(50),
  password: z.string().min(8).max(16),
});

const Login = () => {
  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      username: "",
    },
  });

  function onSubmit(values: z.infer<typeof formSchema>) {
    // perform authentication here.
    console.log(values);
  }
  return (
    <div className="grid grid-cols-1 md:grid-cols-2 h-[100%] bg-white">
      <div className="h-[100%] p-8 login-form flex flex-col justify-center items-center">
        <div className="absolute top-8 left-8">
          <Image width={150} src={logo} alt="site logo" />
        </div>
        <div className="">
          <p className="text-center text-xl pb-2">Welcome back</p>
          <p className="text-center text-md pb-6 text-[#8F8F8F]">
            Enter your username and password to login
          </p>

          <Form {...form}>
            <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
              <FormField
                control={form.control}
                name="username"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel className="text-base">
                      Username <span className="text-runnam-red">*</span>
                    </FormLabel>
                    <FormControl>
                      <Input
                        className="bg-transparent block w-[500px] py-6"
                        placeholder="Enter your username"
                        {...field}
                      />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
              <FormField
                control={form.control}
                name="password"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel className="text-base">
                      Password <span className="text-runnam-red">*</span>
                    </FormLabel>
                    <FormControl>
                      <Input
                        className="bg-transparent block w-[500px] py-6"
                        type="password"
                        placeholder="Enter your password"
                        {...field}
                      />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
              <Button type="submit" className="text-md w-[500px] #02A479">
                Login
              </Button>
            </form>
          </Form>
        </div>
      </div>

      <div className="bg-[#cacaca] hidden md:block login-cover"></div>
    </div>
  );
};

export default Login;
