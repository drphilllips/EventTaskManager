import React, { Fragment, useState, useEffect } from "react";
import { NavLink } from "./Navbar/NavbarElements";

 
const AddEventFeaturesNeither = () => {
    const [features, setFeatures] = useState([]);
    const [formValues, setFormValues] = useState({});
    const [taskType, setTaskType] = useState([]);
    const [event, setEvent] = useState([]);
    const [associatedWith, setAssociatedWith] = useState("");
    const [task, setTask] = useState([]);
    
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
      useEffect(() => {
        getFeatures();
      }, []);

      async function getTaskType() {
        const res = await fetch("http://localhost:8000/tasktype");
        const TaskTypeArray = await res.json();
        setTaskType(TaskTypeArray);
        console.log(taskType);
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

  
        const onSubmitForm = async (e) => {
          e.preventDefault();
          try {
            const body = formValues;
      
            const res = await fetch("http://localhost:8000/assignFeatureToEvent", {
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
          <form onSubmit={onSubmitForm}>
          <div>
              <h1>              </h1>
              <div className="mt-3">
              <label>Event Features</label>
              
              <br />
              <select
          name="associatedWith"
          value={associatedWithForm.admin}
          onChange={(e) =>
            setAssociatedWith([
              {
                event: event.eventid,
                task: task.taskid
              },
            ])
          }
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
          </div>
          <div className="mt-3">
            <button className="btn btn-success"
                    onClick={(e) => {
                      associatedWithForm(e);
                    }} >Submit</button>
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
 
export default AddEventFeaturesNeither;




