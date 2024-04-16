import React, { Fragment } from "react";
import { NavLink } from "./Navbar/NavbarElements";
 
const FeatureLaunchpad = () => {
    return (<Fragment>
        <h1>Choose a Type of Event Feature</h1>
        <br></br>
                    <div><button><NavLink to="/AddEventFeatures_inventory">
                        Add Internal Inventory
                    </NavLink></button></div>
                    <br></br>
                    <div><button><NavLink to="/AddEventFeatures_external">
                        Add External Vendor
                    </NavLink></button></div>
                    <br></br>
                    <div><button><NavLink to="/AddEventFeatures_neither">
                        Add Other Event Feature
                    </NavLink></button></div>
                    </Fragment>
    );
};
 
export default FeatureLaunchpad;