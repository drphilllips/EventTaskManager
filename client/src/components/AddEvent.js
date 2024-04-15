import React, { Fragment, useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";

const AddEvent = () => {
  const [locations, setLocations] = useState([]);
  const [formValues, setFormValues] = useState({});
  const navigate = useNavigate();
  //   event_name: "",
  //   attendees_count: 0,
  //   start_date: "",
  //   start_time: "",
  //   end_time: "",
  //   location: "",
  //   description: "",
  const handleChange = (event) => {
    const name = event.target.name;
    const value = event.target.value;

    setFormValues({ ...formValues, [name]: value });
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

  async function onSubmitForm(e) {
    e.preventDefault();
    try {
      const body = formValues;

      const res = await fetch("http://localhost:8000/events", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });
      console.log(res);
      console.log(formValues);
      navigate("/eventrequest/assignHostandAdmin");
    } catch (error) {
      console.error(error.message);
    }
  }

  return (
    <Fragment>
      <h1>Create an Event</h1>
      <div>
        <form onSubmit={onSubmitForm}>
          <div className="mt-3">
            <label>Event Name:</label>
            <br />
            <input
              type="text"
              name="event_name"
              value={formValues.event_name}
              onChange={handleChange}
            />
          </div>
          <div className="mt-3">
            <label>Number of Expected Attendees::</label>
            <br />
            <input
              type="number"
              name="attendees_count"
              value={formValues.attendees_count}
              onChange={handleChange}
            />
          </div>
          <div className="mt-3">
            <label>Start Date:</label>
            <br />
            <input
              type="date"
              name="start_date"
              value={formValues.start_date}
              onChange={handleChange}
            />
          </div>
          <div className="mt-3">
            <label>Start Time:</label>
            <br />
            <input
              type="time"
              name="start_time"
              value={formValues.start_time}
              onChange={handleChange}
            />
          </div>
          <div className="mt-3">
            <label>End Time:</label>
            <br />
            <input
              type="time"
              name="end_time"
              value={formValues.end_time}
              onChange={handleChange}
            />
          </div>
          <div className="mt-3">
            <label>Location</label>
            <br />
            <select
              name="location"
              value={formValues.location}
              onChange={handleChange}
            >
              <option value={""}>Select a Location</option>
              {locations.map((location) => (
                <option key={location.locid} value={Number(location.locid)}>
                  {location.location_name}
                </option>
              ))}
            </select>
          </div>
          <div className="mt-3">
            <label>description:</label>
            <br />
            <textarea
              type="time"
              name="description"
              value={formValues.description}
              onChange={handleChange}
            />
          </div>
          <div className="mt-3">
            <button
              onClick={(e) => {
                onSubmitForm(e);
              }}
            >
              Next -{">"}
            </button>
          </div>
        </form>
      </div>
    </Fragment>
  );
};

export default AddEvent;
