import React, { Fragment } from "react";
import logo from "./logo.svg";
import "./App.css";
import ActiveEvents from "./components/ActiveEvents";
import PendingEvents from "./components/PendingEvents";
import AddEvent from "./components/AddEvent";
import AddHostandAdmin from "./components/AddHostandAdmin";
import EventSummary from "./pages/EventsSummary";
import CreateEventpage from "./pages/CreateEventPage";

function App() {
  return (
    <Fragment>
      <div className="App">
        <EventSummary />
      </div>
    </Fragment>
  );
}

export default App;
