import React, { Fragment, useState, useEffect } from "react";
import { NavLink } from "./Navbar/NavbarElements";
 
const AddEventFeaturesExternal = () => {
    const [features, setFeatures] = useState([]);
    const [formValues, setFormValues] = useState({});
    const [taskType, setTaskType] = useState([]);
    const [company, setCompany] = useState([]);

    //   event_name: "",
    //   attendees_count: 0,
    //   start_date: "",
    //   start_time: "",
    //   end_time: "",
    //   location: "",
    //   description: "",
    const handleChange = (feature) => {
      const name = feature.target.name;
      const value = feature.target.value;
  
      setFormValues({ ...formValues, [name]: value });
    };
  
  
      async function getFeatures() {
          const res = await fetch("http://localhost:8000/features");
          const featuresArray = await res.json();
          setFeatures(featuresArray);
          console.log(features);
        }
        async function getTaskType() {
          const res = await fetch("http://localhost:8000/tasktype");
          const TaskTypeArray = await res.json();
          setTaskType(TaskTypeArray);
          console.log(taskType);
        }
        async function getCompanies() {
            const res = await fetch("http://localhost:8000/company");
            const companyArray = await res.json();
            setCompany(companyArray);
            console.log(company);
          }
        useEffect(() => {
            getFeatures();
            getTaskType();
            getCompanies();
          }, []);
  
  
  
        const onSubmitForm = async (e) => {
          e.preventDefault();
          try {
            const body = formValues;
      
            const res = await fetch("http://localhost:8000/features", {
              method: "POST",
              headers: { "Content-Type": "application/json" },
              body: JSON.stringify(body),
            });
            console.log(res);
            console.log(formValues);
          } catch (error) {
            console.error(error.message);
          }
        };
  
      return (
        <Fragment>
          <form>
          <div>
              <h1>
              <div className="mt-3">
              <label>Event Features</label>
              <br />
              <select
                name="Features"
                value={formValues.feature}
                onChange={handleChange}
              >
                <option value={""}>Select an Event Feature</option>
                {features.map((feature) => (
                  <option key={feature.featureid} value={Number(feature.featureid)}>
                    {feature.feature_name}
                  </option>
                ))}
              </select>
            </div>
            <div className="mt-3">
              <label>Task Type</label>
              <br />
              <select
                name="taskType"
                value={formValues.task}
                onChange={handleChange}
              >
                <option value={""}>Select a Task Type</option>
                {taskType.map((task) => (
                  <option key={taskType.typeid} value={Number(taskType.typeid)}>
                    {task.type_name}
                  </option>
                ))}
              </select>
            </div>
            <div className="mt-3">
              <label>Company</label>
              <br />
              <select
                name="company"
                value={formValues.company}
                onChange={handleChange}
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
  </div>
              </h1>
          </div>
          <div className="mt-3">
            <button className="btn btn-success" >Submit</button>
          </div>
          </form>
            <button>
                            <NavLink to="/ ">
                                Home
                            </NavLink> </button>
                            <button>
                            <NavLink to="/feature_launchpad_page ">
                                Add Another Feature
                            </NavLink>
                    </button>
                </Fragment>
    );
  };
 
export default AddEventFeaturesExternal;

