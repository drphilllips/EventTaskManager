 
import React, {Fragment} from "react";
 
const Home = () => {
    return <Fragment><h1>Event Gallery (connect these to back end at some point)</h1> <table className="table mt-t text-center">
    <thead>
      <tr>
        <th>Event Name</th>
        <th>Description</th>
        <th>Location</th>
        <th>Date</th>
        <th>Start Time</th>
        <th>End Time</th>
        <th>Edit</th>
        <th>Delete</th>
      </tr>
    </thead>

    <tbody>
    {/*<tr>
        <td>John</td>
        <td>Doe</td>
        <td>john@example.com</td>
</tr> */}
        <tr>
            <td>Event Name</td>
            <td>Event Description</td>
            <td>Location</td>
            <td>Date</td>
            <td>Start Time</td>
            <td>End Time</td>
            <td><button className="btn btn-danger" >Edit</button></td>
            <td>
                <button className="btn btn-danger" >Delete</button>
                </td>
        </tr>
    </tbody>
  </table>
  </Fragment>;
};
 
export default Home;