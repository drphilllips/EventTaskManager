import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";

const EventDetails = () => {
  const params = useParams();
  const [eventAttributes, setEventAttributes] = useState([]);
  const [locationData, setLocationData] = useState([]);
  const [hosts, setHosts] = useState([]);
  const [admins, setAdmins] = useState([]);
  const [completedtasks, setCompletedtasks] = useState([]);
  const [uncompletedtasks, setUnCompletedtasks] = useState([]);
  // // console.log(params);
  // console.log(eventAttributes);
  // console.log(locationData);
  // // console.log(admins);

  // // const location = getLocationData();
  // // console.log(location);
  const startDate = new Date(eventAttributes.start_date);

  const FormattedDate = startDate.toLocaleDateString("en-US", {
    weekday: "long",
    year: "numeric",
    month: "long",
    day: "numeric",
  });

  async function getAnEvent() {
    const res = await fetch(`http://localhost:8000/events/${params.id}`);
    const event_array = await res.json();
    setEventAttributes(event_array[0]);
    // getLocationData();
  }

  useEffect(() => {
    getAnEvent();
  }, []);

  async function getEventHost() {
    const res = await fetch(`http://localhost:8000/event_hosting/${params.id}`);
    const hosts_array = await res.json();
    setHosts(hosts_array);
  }

  useEffect(() => {
    getEventHost();
  }, []);

  async function getEventAdmins() {
    const res = await fetch(`http://localhost:8000/event_admins/${params.id}`);
    const admin_array = await res.json();
    setAdmins(admin_array);
  }

  useEffect(() => {
    getEventAdmins();
  }, []);

  async function getCompletedtasks() {
    const res = await fetch(`http://localhost:8000/completetasks/${params.id}`);
    const completedtasks_array = await res.json();
    setCompletedtasks(completedtasks_array);
  }

  useEffect(() => {
    getCompletedtasks();
  }, []);

  async function getUnCompletedtasks() {
    const res = await fetch(
      `http://localhost:8000/incompletetasks/${params.id}`
    );
    const uncompletedtasks_array = await res.json();
    setUnCompletedtasks(uncompletedtasks_array);
  }

  useEffect(() => {
    getUnCompletedtasks();
  }, []);

  return (
    <>
      <div>
        <h1>Event: {eventAttributes.event_name}</h1>
      </div>
      <br></br>
      <div>
        <h2>Location: {eventAttributes.location}</h2>
      </div>
      <div>
        <h2>
          When: {FormattedDate} from {eventAttributes.start_time} -{" "}
          {eventAttributes.end_time}{" "}
        </h2>
      </div>
      <br></br>
      <div>
        <h2>Description:</h2>
        <div>
          <h3>{eventAttributes.description}</h3>
        </div>
      </div>
      <br></br>
      <div>
        <div>
          <h2>Admin(s):</h2>
          {admins.map((admin) => (
            <ul key={admin.userid}>
              <h3>{admin.host}</h3>
            </ul>
          ))}
        </div>
        <h2>Host(s)</h2>
        <div>
          {hosts.map((host) => (
            <ul key={host.userid}>
              <h3>{host.host}</h3>
            </ul>
          ))}
        </div>
      </div>
      <br></br>
      <h2>Completed tasks:</h2>
      <table className="table">
        <thead>
          <tr>
            <th>
              <h3>task Name</h3>
            </th>
            <th>
              <h3>Completed By</h3>
            </th>
            <th>
              <h3>Completed On</h3>
            </th>
          </tr>
        </thead>
        <tbody>
          {completedtasks.map((task) => (
            <tr key={task.taskid}>
              <td>
                <h4>{task.task_name}</h4>
              </td>
              <td>
                <h4>{task.completed_by}</h4>
              </td>
              <td>
                <h4>{task.completed_on}</h4>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
      <br></br>
      <h2>Uncompleted tasks:</h2>
      <table className="table">
        <thead>
          <tr>
            <th>
              <h3>Task Name</h3>
            </th>
            <th>
              <h3>Assigned By</h3>
            </th>
            <th>
              <h3>Assigned To</h3>
            </th>
            <th>
              <h3>Due Date</h3>
            </th>
          </tr>
        </thead>
        <tbody>
          {uncompletedtasks.map((task) => (
            <tr key={task.taskid}>
              <td>
                <h4>{task.task_name}</h4>
              </td>
              <td>
                <h4>{task.assigned_by}</h4>
              </td>
              <td>
                <h4>{task.assigned_to}</h4>
              </td>
              <td>
                <h4>{task.due_date}</h4>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
      <br></br>
    </>
  );
};

export default EventDetails;
