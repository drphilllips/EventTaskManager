import React, { Fragment } from "react";
import logo from "./logo.svg";
import "./App.css";
import ActiveEvents from "./components/ActiveEvents";
import PendingEvents from "./components/PendingEvents";
import AddEvent from "./components/AddEvent";

function App() {
  return (
    <Fragment>
      <div className="App">
        <AddEvent />
      </div>
    </Fragment>
  );
}

export default App;
