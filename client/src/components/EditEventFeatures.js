import React, { useState } from "react";

const EditEventFeatures = ({ feature }) => {
  const [defaultInputs, setDefaultInputs] = useState({
    feature_name: feature.feature_name,
    description: feature.description,
  });
  const [inputs, setInputs] = useState(defaultInputs);
  console.log("features", feature);
  console.log(inputs);

  const handleChange = (event) => {
    const name = event.target.name;
    const value = event.target.value;
    setInputs({ ...inputs, [name]: value });
  };

  const EditEventFeature = async (id) => {
    try {
      const body = inputs;
      const res = await fetch(`http://localhost:8000/features/${id}`, {
        method: "PUT",
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
        class="btn btn-warning"
        data-bs-toggle="modal"
        data-bs-target={`#id${feature.featureid}`}
      >
        Edit
      </button>

      <div
        class="modal modal-dialog-scrollable"
        id={`id${feature.featureid}`}
        tabindex="-1"
        aria-labelledby="exampleModalLabel"
        aria-hidden="true"
        onClick={() => setDefaultInputs(defaultInputs)}
      >
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h1 class="modal-title fs-5" id="exampleModalLabel">
                Edit Event Feature
              </h1>
              <button
                type="button"
                class="btn-close"
                data-bs-dismiss="modal"
                aria-label="Close"
                onClick={() => setDefaultInputs(defaultInputs)}
              ></button>
            </div>
            <div class="modal-body">
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

            <div class="modal-footer">
              <button
                type="button"
                class="btn btn-danger"
                data-bs-dismiss="modal"
                onClick={() => setDefaultInputs(defaultInputs)}
              >
                Cancel
              </button>
              <button
                type="button"
                class="btn btn-success"
                onClick={() => EditEventFeature(feature.featureid)}
              >
                Save changes
              </button>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default EditEventFeatures;
