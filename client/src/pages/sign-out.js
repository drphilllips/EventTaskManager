import React, {Fragment} from "react";
 
const SignOut = () => {
    return <Fragment><h1>Event Gallery (connect these to back end at some point)</h1> <table className="table mt-t text-center">
    <thead>
      <tr>
        <th></th>
        <th></th>
      </tr>
    </thead>

    <tbody>
    {/*<tr>
        <td>John</td>
        <td>Doe</td>
        <td>john@example.com</td>
</tr> */}
        <tr>
            <td>User Name</td>
            <td>Put Their User Name</td>        </tr>
            <tr>
            <td>User Type</td>
            <td>Put Their User Type</td>        </tr>
    </tbody>
  </table>
  <button>Sign Out (does nothing currently)</button>
  </Fragment>;
};
 
export default SignOut;

