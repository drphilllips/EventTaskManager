import React, { Fragment, useEffect, useState } from "react";

const ActiveEvents = () => {
  const [active_events, setActive_events] = useState([]);

  async function getActiveEvents() {
    const res = await fetch("http://localhost:8000/active_events");
    const active_events_array = await res.json();

    setActive_events(active_events_array);
  }

  useEffect(() => {
    getActiveEvents();
  }, []);

  console.log(active_events);
  return (
    <Fragment>
      <h1>Active Events</h1>
      <table className="table">
        <thead>
          <tr>
            <th>Event name</th>
            <th>Attendee Count</th>
            <th>Date</th>
            <th>Start Time</th>
            <th>End Time</th>
            <th>Location</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
          {active_events.map((active_event) => (
            <tr key={active_event.eventid}>
              <td>{active_event.event_name}</td>
              <td>{active_event.attendees_count}</td>
              <td>{active_event.start_date}</td>
              <td>{active_event.start_time}</td>
              <td>{active_event.end_time}</td>
              <td>{active_event.location}</td>
              <td>{active_event.description}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </Fragment>
  );
};

export default ActiveEvents;
