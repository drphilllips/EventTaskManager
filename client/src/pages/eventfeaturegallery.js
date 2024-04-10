import React, {Fragment} from "react";
 
const EventFeatureGallery = () => {
    return <Fragment><h1>Event Feature Gallery (connect these to back end at some point) (Figure out how to hide this from non-admins later)</h1> <table className="table mt-t text-center">
    <thead>
      <tr>
        <th>Feature Name</th>
        <th>Description</th>
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
            <td>Feature Name</td>
            <td>Feature Description</td>
            <td><button className="btn btn-danger" >Edit</button></td>
            <td>
                <button className="btn btn-danger" >Delete</button>
                </td>
        </tr>
    </tbody>
  </table>
  </Fragment>;
};
 
export default EventFeatureGallery;