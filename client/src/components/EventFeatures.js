import React, { Fragment, useState, useEffect } from "react";

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
  }, []);


  return (
    <Fragment>
      <h1>Event Feature Gallery (Hide from Non Admins?)</h1>
      <table className="table">
        <thead>
          <tr>
            <th>Event Feature Name</th>
            <th>Event Feature Description</th>
            <th>Edit</th>
          </tr>
        </thead>
        <tbody>
          {features.map((features) => (
            <tr key={features.featureid}>
              <td>{features.feature_name}</td>
              <td>{features.description}</td>
              <td><button>Edit</button></td>
            </tr>
          ))}
        </tbody>
      </table>
    </Fragment>
  );

};

export default EventFeatures;