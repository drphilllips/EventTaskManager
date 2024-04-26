import React, { Fragment, useState, useEffect } from "react";
import EditEventFeatures from "./EditEventFeatures";

const EventFeatures = () => {
  const [features, setFeatures] = useState([]);

  async function getFeatures() {
    const res = await fetch("http://localhost:8000/features");
    const featuresArray = await res.json();
    setFeatures(featuresArray);
  }

  // Delete Event Feature function
  async function DeleteEventFeature(id) {
    try {
      const res = await fetch(`http://localhost:8000/features/${id}`, {
        method: "DELETE",
      });
      console.log(res);
      setFeatures(features.filter((feature) => feature.featureid !== id));
    } catch (error) {
      console.error(error.message);
    }
  }

  useEffect(() => {
    getFeatures();
  });

  return (
    <Fragment>
      <h1>Event Feature Gallery</h1>
      <table className="table">
        <thead>
          <tr>
            <th></th>
            <th></th>
            <th>Event Feature Name</th>
            <th>Event Feature Description</th>
          </tr>
        </thead>
        <tbody>
          {features.map((feature) => (
            <tr key={feature.featureid}>
              <td>
                <button
                  className="btn btn-danger"
                  onClick={() => DeleteEventFeature(feature.featureid)}
                >
                  Delete
                </button>
              </td>
              <td>
                <EditEventFeatures feature={feature} />
              </td>
              <td>{feature.feature_name}</td>
              <td>{feature.description}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </Fragment>
  );
};

export default EventFeatures;
