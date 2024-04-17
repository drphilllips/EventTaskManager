import React from "react";
import { Nav, NavLink, NavMenu } from "./NavbarElements";
 
const Navbar = () => {
    return (
        <>
            <Nav>
                <NavMenu>
                    <NavLink to="/" activeStyle>
                        Events Gallery
                    </NavLink>
                    <NavLink to="/eventrequest" activeStyle>
                        Event Request
                    </NavLink>
                    <NavLink to="/eventfeaturegallery" activeStyle>
                        Event Feature Gallery
                    </NavLink>
                    <NavLink to="/sign-out" activeStyle>
                        Profile
                    </NavLink>
                </NavMenu>
            </Nav>
        </>
    );
};
 
export default Navbar;