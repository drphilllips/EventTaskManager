import React, { Fragment, useEffect, useState } from "react";
import { Link } from "react-router-dom";
import EditEvents from "./EditEvents";

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

  // Delete Event function
  async function DeleteEvent(id) {
    try {
      const res = await fetch(`http://localhost:8000/events/${id}`, {
        method: "DELETE",
      });
      console.log(res);
      setActive_events(
        active_events.filter((active_event) => active_event.eventid !== id)
      );
    } catch (error) {
      console.error(error.message);
    }
  }

  // console.log(active_events);
  return (
    <Fragment>
      <h1>Active Events</h1>
      <table className="table">
        <thead>
          <tr>
            <th></th>
            <th></th>
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
              <td>
                <button
                  className="btn btn-danger"
                  onClick={() => DeleteEvent(active_event.eventid)}
                >
                  Delete
                </button>
              </td>
              <td>
                <EditEvents event={active_event} />
              </td>
              <td>
                <Link to={`/events/${active_event.eventid}`}>
                  {active_event.event_name}
                </Link>
              </td>
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
