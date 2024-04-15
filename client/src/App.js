import React, { Fragment } from "react";
import logo from "./logo.svg";
import "./App.css";
import ActiveEvents from "./components/ActiveEvents";
import PendingEvents from "./components/PendingEvents";
import AddEvent from "./components/AddEvent";
import AddHostandAdmin from "./components/AddHostandAdmin";
import EventSummary from "./pages/EventsSummary";
import CreateEventpage from "./pages/CreateEventPage";

import Navbar from "./components/Navbar";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Home from "./pages";
import About from "./pages/about";
import EventFeatureGallery from "./pages/eventfeaturegallery";
import AssignHostandAdmin from "./pages/AssignHostandAdminPage";
import EventRequest from "./pages/eventrequest";
import SignOut from "./pages/sign-out";
import EventDetails from "./pages/EventDetails";

function App() {
  return (
    <Router>
      <Navbar />
      <Routes>
        <Route exact path="/" element={<Home />} />
        <Route path="/about" element={<About />} />
        <Route path="/eventrequest" element={<EventRequest />} />
        <Route
          path="/eventrequest/assignHostandAdmin"
          element={<AssignHostandAdmin />}
        />
        <Route path="/events/:id" element={<EventDetails />} />
        <Route path="/sign-out" element={<SignOut />} />
        <Route path="/eventfeaturegallery" element={<EventFeatureGallery />} />
      </Routes>
    </Router>
  );
}

/*
function App() {
  return (
    <Fragment>
      <div className="App">
        <EventSummary />
      </div>
    </Fragment>
  );
}

                <Route
                    path="/sign-out"
                    element={<SignOut />}
                />

*/
export default App;
