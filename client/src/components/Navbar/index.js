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

                    <NavLink to="/eventrequest1" activeStyle>
                        Event Request
                    </NavLink>
                    <NavLink to="/eventfeaturegallery" activeStyle>
                        Event Feature Gallery
                    </NavLink>
                    <NavLink to="/about" activeStyle>
                        About
                    </NavLink>
                    <NavLink to="/sign-out" activeStyle>
                        Sign Out
                    </NavLink>
                </NavMenu>
            </Nav>
        </>
    );
};
 
export default Navbar;