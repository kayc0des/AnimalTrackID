"use client"
import { useState, useEffect } from "react";


const DashboardGreeting = () => {
  let time = new Date().toLocaleTimeString()
  const [date, setDate] = useState(new Date())
  const [currentTime, setCurrentTime] = useState(time)
  const hour = date.getHours();

  useEffect(() => {
    const intervalId = setInterval(() => {
      setCurrentTime(new Date().toLocaleTimeString())
    }, 1000);
    return () => {
      clearInterval(intervalId);
    }
  }, [])
  const months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  const days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];
   
  return (
    <div>
      <p className="font-semibold text-2xl">
        {hour > 1 && hour <= 11
          ? "Good morning, Kingsley 👋🏾"
          : hour > 11 && hour < 16
          ? "Good afternoon, Kingsley 👋🏾"
          : hour > 16 || hour == 0
          ? "Good evening, Kingsley 👋🏾"
          : "Hello"}
      </p>
      <p className="text-lg u-text-gray">
        <time dateTime={date.toLocaleDateString()} suppressHydrationWarning={true}>
          {`${days[date.getDay()]}, ${
            months[date.getMonth()]
          } ${date.getDate()}, ${date.getFullYear()}, ${currentTime}`}
        </time>
      </p>
    </div>
  );
};

export default DashboardGreeting;
