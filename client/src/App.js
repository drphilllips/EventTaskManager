import React, { Fragment } from "react";
import Login from "./pages/Login.js";
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
import EventRequest from "./pages/eventrequest1.js";

const App = () => (
  <Fragment>
    <div className="container">
      <Login />
    </div>
    <Router>
            <Navbar />
            <Routes>
                <Route exact path="/" element={<Home />} />
                <Route path="/about" element={<About />} />
                <Route
                    path="/eventrequest1"
                    element={<EventRequest />}
                />
                <Route path="/eventfeaturegallery" element={<EventFeatureGallery />} />
                <Route
                    path="/sign-out"
                    element={<SignOut />}
                />
            </Routes>
        </Router>
  </Fragment>
  
);

export default App;
