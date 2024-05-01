import React, { Fragment, useState, useEffect } from "react";
import { NavLink } from "./Navbar/NavbarElements";
 
const AddEventFeaturesExternal = () => {
  // all features
  const [features, setFeatures] = useState([]);

  // all task types
  const [taskTypes, setTaskTypes] = useState([]);

  //most recent event
  const [event, setEvent] = useState([]);
  
  // all admins
  const [admins, setAdmins] = useState([]);

  // all users
  const [users, setUsers] = useState([]);


  //most recent task
  const [task, setTask] = useState([]);

  // sets the featureis from the from a dropdown
  const [featureID, setFeatureID] = useState("");

  // quantity of feature
  const [quantity, setquantity] = useState();

  // not sure what these are
  const [associatedWith, setAssociatedWith] = useState({});

  // values to be inserted into the tasks table
  const [taskformValues, setTaskFormValues] = useState({});

  // get all companies
  const [company, setCompany] = useState([]);

  console.log("feastures", features);
  console.log("event", event);
  console.log("eventid", event.eventid);
  console.log("task types", taskTypes);
  console.log("featureId", featureID);
  console.log("taskform", taskformValues);
  console.log("admins", admins);
  console.log("users", users);
  console.log("taskid", task);
  console.log("quantity", quantity);

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

    setTaskFormValues({ ...taskformValues, [name]: value });
  };

  async function getFeatures() {
    const res = await fetch("http://localhost:8000/features");
    const featuresArray = await res.json();
    setFeatures(featuresArray);
    console.log(features);
  }
  useEffect(() => {
    getFeatures();
  }, []);

  async function getTaskType() {
    const res = await fetch("http://localhost:8000/tasktype");
    const TaskTypeArray = await res.json();
    setTaskTypes(TaskTypeArray);
    console.log(taskTypes);
  }

  useEffect(() => {
    getTaskType();
  }, []);

  async function getMostRecentEvent() {
    const res = await fetch("http://localhost:8000/mostrecentevents");
    const res_array = await res.json();
    setEvent(res_array[0]);
  }

  useEffect(() => {
    getMostRecentEvent();
  }, []);

  async function getMostRecentTask() {
    const res = await fetch("http://localhost:8000/mostrecenttask");
    const res_array = await res.json();
    setTask(res_array[0]);
  }

  useEffect(() => {
    getMostRecentTask();
  }, []);

  async function getAllAdmins() {
    const res = await fetch(`http://localhost:8000/event_admins/${event.eventid}`);
    const res_array = await res.json();
    setAdmins(res_array);
  }
  useEffect(() => {
      getAllAdmins();
  }, [event.eventid]);


  
  async function getAllUsers() {
    const res = await fetch("http://localhost:8000/users");
    const res_array = await res.json();
    setUsers(res_array);
  }
  useEffect(() => {
    getAllUsers();
  }, []);

  /*
  async function getAllUsers() {
    const res = await fetch(`http://localhost:8000/event_hosting/${event.eventid}`);
    const res_array = await res.json();
    setUsers(res_array);
  }
  useEffect(() => {
    getAllUsers();
  }, [event.eventid]);
  */

  async function putTask(e) {
    e.preventDefault();
    try {
      const body = task;

      const res = await fetch("http://localhost:8000/task", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });
      console.log(putTask[0]);
    } catch (error) {
      console.error(error.message);
    }
  }

  async function getCompanies() {
    const res = await fetch("http://localhost:8000/company");
    const companyArray = await res.json();
    setCompany(companyArray);
    console.log(company);
  }
  useEffect(() => {
    getCompanies();
  }, []);

  async function associatedWithForm(e) {
    e.preventDefault();
    try {
      const body = associatedWithForm;

      const res = await fetch("http://localhost:8000/assignEventToTask", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });
      console.log(res);
      console.log(associatedWithForm);
    } catch (error) {
      console.error(error.message);
    }
  }

  const satisfyEventandFeature = async (e) => {
    e.preventDefault();
    try {
      const body = {
        featureid: featureID.featureid,
        quantity: quantity,
      };

      const res = await fetch("http://localhost:8000/satisfies", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });

      console.log(res);
      console.log(body);
    } catch (error) {
      console.error(error.message);
    }
  };

  const associateEventandTask = async (e) => {
    e.preventDefault();
    try {
      const body = {
        eventid: event.eventid,
      };

      const res = await fetch("http://localhost:8000/associated_with", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });

      console.log(res);
      console.log(body);
    } catch (error) {
      console.error(error.message);
    }
  };

  const onSubmitForm = async (e) => {
    e.preventDefault();
    try {
      const body = taskformValues;
      const res = await fetch("http://localhost:8000/tasks", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });
      associateEventandTask(e);
      satisfyEventandFeature(e);


      console.log(res);
      console.log(taskformValues);
    } catch (error) {
      console.error(error.message);
    }
  };

  return (
    <Fragment>
      <form onSubmit={onSubmitForm}>
        <div>
          <h1> </h1>
          <div className="mt-3">
            <label>Event Features</label>
            <br />
            <select
              name="featureid"
              value={featureID.featureid}
              onChange={(e) =>
                setFeatureID({
                  featureid: e.target.value,
                })
              }
            >
              <option value={""}>Select an Event Feature</option>
              {features.map((feature) => (
                <option
                  key={feature.featureid}
                  value={Number(feature.featureid)}
                >
                  {feature.feature_name}
                </option>
              ))}
            </select>
          </div>
          <div className="mt-3">
            <label>Task Type</label>
            <br />
            <select
              name="typeid"
              value={taskformValues.typeid}
              onChange={handleChange}
            >
              <option value={""}>Select a Task Type</option>
              {taskTypes.map((task) => (
                <option key={task.typeid} value={Number(task.typeid)}>
                  {task.type_name}
                </option>
              ))}
            </select>
          </div>
        </div>
        <div className="mt-3">
          <label>Task Name:</label>
          <br />
          <input
            type="text"
            name="task_name"
            value={taskformValues.task_name}
            onChange={handleChange}
          />
        </div>
        <div className="mt-3">
          <label>Assigned By</label>
          <br />
          <select
            name="assigned_by"
            value={taskformValues.assigned_by}
            onChange={handleChange}
          >
            <option value={""}>Select an Admin</option>
            {admins.map((admin) => (
              <option key={admin.userid} value={admin.userid}>
                {admin.host}
              </option>
            ))}
          </select>
        </div>
        <div className="mt-3">
          <label>Assigned To</label>
          <br />
          <select
            name="assigned_to"
            value={taskformValues.assigned_to}
            onChange={handleChange}
          >
            <option value={""}>Select a Person to Assign the task</option>
            {users.map((admin) => (
              <option key={admin.userid} value={admin.userid}>
                {admin.user}
              </option>
            ))}
          </select>
        </div>
        <div className="mt-3">
          <label>Company</label>
          <br />
          <select
            name="company"
          >
            <option value={""}>Select an Outside Vendor</option>
            {company.map((vendor) => (
              <option key={company.companyid} value={Number(company.companyid)}>
                {vendor.comapny_name + ": " + vendor.first_name + " "+ vendor.last_name}
              </option>
            ))}
          </select>
          </div>
        <div className="mt-3">
          <label>Description:</label>
          <br />
          <textarea
            type="text"
            name="description"
            value={taskformValues.description}
            onChange={handleChange}
          />
        </div>

        <div className="mt-3">
          <button
            className="btn btn-success"
            onClick={(e) => {
              onSubmitForm(e);
            }}
          >
            Submit
          </button>
        </div>
      </form>
      <button>
        <NavLink to="/ ">Home</NavLink>{" "}
      </button>
      <button>
        <NavLink to="/feature_launchpad_page ">Add Another Feature</NavLink>
      </button>
    </Fragment>
  );
};
 
export default AddEventFeaturesExternal;








