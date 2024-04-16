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
import {
    BrowserRouter as Router,
    Routes,
    Route,
} from "react-router-dom";
import Home from "./pages";
import About from "./pages/about";
import EventFeatureGallery from "./pages/eventfeaturegallery";
import SignOut from "./pages/sign-out";
import EventRequest from "./pages/eventrequest";
import AddAdmin from "./pages/AddAdminPage";
import FeatureLaunchpadPage from "./pages/feature_launchpad_page";
import AddEventFeaturesExternal from "./components/AddEventFeatures_external";
import AddEventFeaturesInventory from "./components/AddEventFeatures_inventory";
import AddEventFeaturesNeither from "./components/AddEventFeatures_neither";



function App () {
    return (
        <Router>
            <Navbar />
            <Routes>
                <Route exact path="/" element={<Home />} />
                <Route path="/about" element={<About />} />
                <Route
                    path="/eventrequest"
                    element={<EventRequest />}
                />
                <Route path="/sign-out" element={<SignOut />} />
                <Route path="/eventfeaturegallery" element={<EventFeatureGallery />} />
                <Route
                    path="/sign-out"
                    element={<SignOut />}
                />
                  <Route
                    path="/addAdminPage"
                    element={<AddAdmin />}
                />
                <Route
                    path="/feature_launchpad_page"
                    element={<FeatureLaunchpadPage />}
                />
                <Route
                    path="/AddEventFeatures_inventory"
                    element={<AddEventFeaturesInventory />}
                />
                <Route
                    path="/AddEventFeatures_external"
                    element={<AddEventFeaturesExternal />}
                />
                <Route
                    path="/AddEventFeatures_neither"
                    element={<AddEventFeaturesNeither />}
                />
            </Routes>
        </Router>
    );
}
 
export default App;



