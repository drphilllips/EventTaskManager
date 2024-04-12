import React from "react";

import ActiveEvents from "../components/ActiveEvents";
import PendingEvents from "../components/PendingEvents";

const EventSummary = () => {
  return (
    <>
      <ActiveEvents />
      <PendingEvents />
    </>
  );
};

export default EventSummary;
