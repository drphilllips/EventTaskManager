import React from "react";
 
const EventRequest = () => {
    return (
        <div>
        <h1>Event Request Form (connect these to back end at some point)</h1>

        <table className="table mt-t text-center">
    <thead>
      <tr>
        <th> </th>
        <th> </th>
      </tr>
    </thead>

    <tbody>
    {/*<tr>
        <td>John</td>
        <td>Doe</td>
    </tr> */}
    <tr>
        <td>Event Name</td>
        <td>  <form>
          <input
            type="event name"
            placeholder="Event Name"
          />
                  </form></td>
    </tr>     <tr>
            <td>Location</td>
        <td>                    <form>
        <select>
                <option value = "location">Location1</option>
                <option value = "location">Location2</option>
                <option value = "location">Location3</option>
                <option value = "location">Location4</option>
                </select>
                  </form></td>    </tr> 
                  <tr>
            <td>Date</td>
        <td>                    <form>
          <input
            type="Date"
            placeholder="Date"
          />
                  </form></td>    </tr>
                  <tr>
            <td>Start Time</td>
        <td>                    <form>
          <input
            type="Time"
            placeholder="Time"
          />
                  </form></td>    </tr>
                  <tr>
            <td>End Time</td>
        <td>                    <form>
          <input
            type="Time"
            placeholder="Time"
          />
                  </form></td>    </tr>
                  <tr>
            <td>Description</td>
        <td>                    <form>
          <input
            type="Varchar(255)"
            placeholder="Description"
          />
                  </form></td>    </tr>

      
    </tbody>
  </table>


          <button type="submit">Submit</button>

      </div>
    );
};
 
export default EventRequest;