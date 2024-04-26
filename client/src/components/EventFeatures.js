import React, { Fragment, useState, useEffect } from "react";
import EditEventFeatures from "./EditEventFeatures";

const EventFeatures = () => {
  const [features, setFeatures] = useState([]);

  async function getFeatures() {
    const res = await fetch("http://localhost:8000/features");
    const featuresArray = await res.json();
    setFeatures(featuresArray);
    console.log(features);
  }

  useEffect(() => {
    getFeatures();
  }, );

  return (
    <Fragment>
      <h1>Event Feature Gallery</h1>
      <table className="table">
        <thead>
          <tr>
            <th>Event Feature Name</th>
            <th>Event Feature Description</th>
            <th>Edit</th>
          </tr>
        </thead>
        <tbody>
          {features.map((feature) => (
            <tr key={feature.featureid}>
              <td>{feature.feature_name}</td>
              <td>{feature.description}</td>
              <td>
                <EditEventFeatures feature={feature} />
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </Fragment>
  );
};

export default EventFeatures;
