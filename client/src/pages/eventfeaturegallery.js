import React from "react";
import EventFeatures from "../components/EventFeatures";
import AddEventFeatures from "../components/AddEventFeature";

const EventFeatureGallery = () => {
  return (
    <div>
      <h1>
        <EventFeatures />
      </h1>
      <AddEventFeatures />
    </div>
  );
};

export default EventFeatureGallery;
