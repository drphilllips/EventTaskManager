import React, { Fragment } from "react";
import logo from "./logo.svg";
import "./App.css";
import ActiveEvents from "./components/ActiveEvents";
import PendingEvents from "./components/PendingEvents";

function App() {
  return (
    <Fragment>
      <div className="App">
        <ActiveEvents />
        <br></br>
        <PendingEvents />
      </div>
    </Fragment>
  );
}

export default App;
