import React, { useState, useEffect } from "react";

const AddEventFeatures = ({ feature }) => {
  const [defaultInputs, setDefaultInputs] = useState({
    feature_name: "",
    description: "",
  });
  const [inputs, setInputs] = useState(defaultInputs);

  useEffect(() => {
    // Set default inputs whenever the component mounts
    setDefaultInputs({
      feature_name: "",
      description: "",
    });
  }, []);

  const handleChange = (event) => {
    const { name, value } = event.target;
    setInputs({ ...inputs, [name]: value });
  };

  const AddEventFeature = async () => {
    try {
      const body = inputs;
      const res = await fetch(`http://localhost:8000/features`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });
      console.log(res);
      window.location = "/eventfeaturegallery";
    } catch (error) {
      console.error(error.message);
    }
  };

  return (
    <>
      <button
        type="button"
        className="btn btn-success"
        data-bs-toggle="modal"
        data-bs-target="#addFeatureModal"
      >
        Add Event Feature
      </button>

      <div
        className="modal modal-dialog-scrollable"
        id="addFeatureModal"
        tabIndex="-1"
        aria-labelledby="exampleModalLabel"
        aria-hidden="true"
      >
        <div className="modal-dialog">
          <div className="modal-content">
            <div className="modal-header">
              <h1 className="modal-title fs-5" id="exampleModalLabel">
                Add Event Feature
              </h1>
              <button
                type="button"
                className="btn-close"
                data-bs-dismiss="modal"
                aria-label="Close"
                onClick={() => setDefaultInputs(defaultInputs)}
              ></button>
            </div>
            <div className="modal-body">
              <div className="mt-3">
                <div>
                  <label>Feature Name:</label>
                </div>
                <input
                  type="text"
                  name="feature_name"
                  value={inputs.feature_name}
                  onChange={handleChange}
                ></input>
              </div>
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

            <div className="modal-footer">
              <button
                type="button"
                className="btn btn-danger"
                data-bs-dismiss="modal"
                onClick={() => setDefaultInputs(defaultInputs)}
              >
                Cancel
              </button>
              <button
                type="button"
                className="btn btn-success"
                onClick={() => AddEventFeature()}
              >
                Create Feature
              </button>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default AddEventFeatures;
