import React, { Fragment, useEffect, useState } from "react";
import { NavLink } from "./Navbar/NavbarElements";

const AddHostandAdmin = () => {
  const [hostcount, sethostcount] = useState(1);
  const [event, setEvent] = useState([]);
  const [hosts, setHosts] = useState([]);
  const [admins, setAdmins] = useState([]);
  const [adminsform, setAdminfomr] = useState("");
  const [hostform, setHostform] = useState("");

  const handleChange = (event) => {
    const name = event.target.name;
    const value = event.target.value;

    setHostform({ ...hostform, [name]: value });
  };

  async function getMostRecentEvent() {
    const res = await fetch("http://localhost:8000/mostrecentevents");
    const res_array = await res.json();
    setEvent(res_array[0]);
  }
  useEffect(() => {
    getMostRecentEvent();
  }, []);

  async function getAllHosts() {
    const res = await fetch("http://localhost:8000/eventhosts");
    const res_array = await res.json();
    setHosts(res_array);
  }
  useEffect(() => {
    getAllHosts();
  }, []);

  async function getAllAdmins() {
    const res = await fetch("http://localhost:8000/eventadmins");
    const res_array = await res.json();
    setAdmins(res_array);
  }
  useEffect(() => {
    getAllAdmins();
  }, []);

  async function assignhost(e) {
    e.preventDefault();
    try {
      const body = hostform[0];

      const res = await fetch("http://localhost:8000/hosts", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });
      console.log(res);
      console.log(hostform[0]);
    } catch (error) {
      console.error(error.message);
    }
  }

  async function assignAdmin(e) {
    e.preventDefault();
    try {
      const body = adminsform[0];

      const res = await fetch("http://localhost:8000/administrates", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });
      console.log(res);
      console.log(adminsform[0]);
    } catch (error) {
      console.error(error.message);
    }
  }
  console.log(hostform);
  console.log(adminsform);
  console.log(event.eventid);
  return (
    <Fragment>
      <h1>Host and Admin</h1>

      <div className="mt-3">
        <label> Please choose a host</label>
        <br></br>
        <select
          name="host"
          value={hostform.host}
          onChange={(e) =>
            setHostform([
              {
                event: event.eventid,
                host: e.target.value,
              },
            ])
          }
        >
          <option value={""}>Select a Host</option>
          {hosts.map((host) => (
            <option key={host.userid} value={host.userid}>
              {host.host}
            </option>
          ))}
        </select>
      </div>
      <div className="mt-3">
        <label> Please choose an Admin</label>
        <br></br>
        <select
          name="admin"
          value={adminsform.admin}
          onChange={(e) =>
            setAdminfomr([
              {
                event: event.eventid,
                admin: e.target.value,
              },
            ])
          }
        >
          <option value={""}>Select an Admin</option>
          {admins.map((admin) => (
            <option key={admin.userid} value={admin.userid}>
              {admin.host}
            </option>
          ))}
        </select>
      </div>
      <button
        className="mt-5"
        onClick={(e) => {
          assignhost(e);
          assignAdmin(e);
        }}
      >
       <NavLink to="/feature_launchpad_page ">
                        Next
                    </NavLink>
      </button>
    </Fragment>
  );
};

export default AddHostandAdmin;
