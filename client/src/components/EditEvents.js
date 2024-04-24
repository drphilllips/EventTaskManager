import React, { useState, useEffect } from "react";

const EditEvents = ({ event }) => {
  //   Format time properly
  function getTime(time) {
    return time.slice(0, 5);
  }

  // Formt the date properly
  function getDate(timestamp) {
    var date_not_formatted = new Date(timestamp);

    var formatted_string = date_not_formatted.getFullYear() + "-";

    if (date_not_formatted.getMonth() < 9) {
      formatted_string += "0";
    }
    formatted_string += date_not_formatted.getMonth() + 1;
    formatted_string += "-";

    if (date_not_formatted.getDate() < 10) {
      formatted_string += "0";
    }
    formatted_string += date_not_formatted.getDate();
    return formatted_string;
  }

  //   console.log("form string", getDate(event.start_time_date));
  const [defaultInputs, setDefaultInputs] = useState({
    event_name: event.event_name,
    attendees_count: event.attendees_count,
    start_date: getDate(event.start_time_date),
    start_time: getTime(event.start_time),
    end_time: getTime(event.end_time),
    location: event.locid,
    description: event.description,
  });

  const [locations, setLocations] = useState([]);
  const [inputs, setInputs] = useState(defaultInputs);
  console.log("events", event);
  console.log(inputs);

  const handleChange = (event) => {
    const name = event.target.name;
    const value = event.target.value;
    setInputs({ ...inputs, [name]: value });
  };

  const EditEvent = async (id) => {
    try {
      const body = inputs;
      const res = await fetch(`http://localhost:8000/events/${id}`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });
      console.log(res);
      window.location = "/";
    } catch (error) {
      console.error(error.message);
    }
  };

  async function getLocations() {
    const res = await fetch("http://localhost:8000/locations");
    const locationsArray = await res.json();
    setLocations(locationsArray);
    console.log(locations);
  }

  useEffect(() => {
    getLocations();
  }, []);

  return (
    <>
      <button
        type="button"
        class="btn btn-warning"
        data-bs-toggle="modal"
        data-bs-target={`#id${event.eventid}`}
      >
        Edit
      </button>

      <div
        class="modal modal-dialog-scrollable"
        id={`id${event.eventid}`}
        tabindex="-1"
        aria-labelledby="exampleModalLabel"
        aria-hidden="true"
        onClick={() => setDefaultInputs(defaultInputs)}
      >
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h1 class="modal-title fs-5" id="exampleModalLabel">
                Edit Event
              </h1>
              <button
                type="button"
                class="btn-close"
                data-bs-dismiss="modal"
                aria-label="Close"
                onClick={() => setDefaultInputs(defaultInputs)}
              ></button>
            </div>
            <div class="modal-body">
              <div className="mt-3">
                <div>
                  <label>Event Name:</label>
                </div>
                <input
                  type="text"
                  name="event_name"
                  value={inputs.event_name}
                  onChange={handleChange}
                ></input>
              </div>
              <div className="mt-3">
                <div>
                  <label>Number of Attendees:</label>
                </div>
                <input
                  type="number"
                  name="attendees_count"
                  value={inputs.attendees_count}
                  onChange={handleChange}
                ></input>
              </div>
              <div className="mt-3">
                <div>
                  <label>Date:</label>
                </div>
                <input
                  type="date"
                  name="start_date"
                  value={inputs.start_date}
                  onChange={handleChange}
                ></input>
              </div>{" "}
              <div className="mt-3">
                <div>
                  <label>Start Time:</label>
                </div>
                <input
                  type="time"
                  name="start_time"
                  value={inputs.start_time}
                  onChange={handleChange}
                ></input>
              </div>{" "}
              <div className="mt-3">
                <div>
                  <label>End Time:</label>
                </div>
                <input
                  type="time"
                  name="end_time"
                  value={inputs.end_time}
                  onChange={handleChange}
                ></input>
              </div>{" "}
              <div className="mt-3">
                <div>
                  <label>Location:</label>
                </div>
                <select
                  name="location"
                  value={inputs.location}
                  onChange={handleChange}
                >
                  <option value={""}>Select a Location</option>
                  {locations.map((location) => (
                    <option key={location.locid} value={Number(location.locid)}>
                      {location.location_name}
                    </option>
                  ))}
                </select>
              </div>{" "}
              <div className="mt-3">
                <div>
                  <label>Description:</label>
                </div>
                <textarea
                  type="text"
                  name="description"
                  value={inputs.description}
                  onChange={handleChange}
                ></textarea>
              </div>
            </div>

            <div class="modal-footer">
              <button
                type="button"
                class="btn btn-danger"
                data-bs-dismiss="modal"
                onClick={() => setDefaultInputs(defaultInputs)}
              >
                Cancel
              </button>
              <button
                type="button"
                class="btn btn-success"
                onClick={() => EditEvent(event.eventid)}
              >
                Save changes
              </button>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default EditEvents;
