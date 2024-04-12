import React, { Fragment } from "react";
import logo from "./logo.svg";
import "./App.css";
import ActiveEvents from "./components/ActiveEvents";
import PendingEvents from "./components/PendingEvents";
import AddEvent from "./components/AddEvent";
import AddHostandAdmin from "./components/AddHostandAdmin";
import EventSummary from "./pages/EventsSummary";

function App() {
  return (
    <Fragment>
      <div className="App">
        <EventSummary />
        <AddEvent />
        <AddHostandAdmin />
      </div>
    </Fragment>
  );
}

export default App;
