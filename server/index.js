const express = require("express");
const app = express();
const cors = require("cors");
const pool = require("./db");

// Midware
app.use(cors());
app.use(express.json()); // allows access to request.body
// data from the client side

// ROUTES:

// Login with email and password
app.get("/users?:email&:password");

// create a user
// userid | first_name| last_name | user_password | phone | email

app.post("/users", async (req, res) => {
  // await
  try {
    const { userid, first_name, last_name, user_password, phone, email } =
      req.body;
    const newUser = await pool.query(
      "INSERT INTO users (userid, first_name, last_name, user_password, phone, email)\
            VALUES($1, $2, $3, $4, $5, $6)\
            RETURNING *",
      [userid, first_name, last_name, user_password, phone, email]
    );
    res.json(newUser.rows[0]);
  } catch (err) {
    console.error(err.message);
  }
});

// get all users

app.get("/users", async (req, res) => {
  try {
    const allUsers = await pool.query("SELECT * FROM users");
    res.json(allUsers.rows);
  } catch (err) {
    console.error(err.message);
  }
});

// get a user

app.get("/users/:userid", async (req, res) => {
  try {
    console.log(req.params);
    const { userid } = req.params;
    const user = await pool.query("SELECT * FROM users WHERE userid = $1", [
      userid,
    ]);
    res.json(user.rows[0]);
  } catch (err) {
    console.error(err.message);
  }
});

// update a user

app.put("/users/:userid", async (req, res) => {
  try {
    const { userid } = req.params;
    const { first_name, last_name, user_password, phone, email } = req.body;
    const updateUser = await pool.query(
      "UPDATE users\
            SET first_name = $2, last_name = $3, user_password = $4, phone = $5, email = $6\
            WHERE userid = $1",
      [userid, first_name, last_name, user_password, phone, email]
    );
    res.json("Users was updated.");
  } catch (err) {
    console.error(err.message);
  }
});

// delete a user

app.delete("/users/:userid", async (req, res) => {
  try {
    const { userid } = req.params;
    const deleteUser = await pool.query("DELETE FROM users WHERE userid = $1", [
      userid,
    ]);
    res.json("User was deleted.");
  } catch (err) {
    console.error(err.message);
  }
});

// Get all locations
app.get("/locations", async (req, res) => {
  try {
    const allLocations = await pool.query(
      "select * from locations order by location_name asc"
    );
    res.json(allLocations.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// Get a location
app.get("/locations/:loc", async (req, res) => {
  try {
    const { loc } = req.params;
    const location = await pool.query(
      "select * from locations where locid = $1",
      [loc]
    );
    res.json(location.rows[0]);

    // console.log(req.params);
  } catch (error) {
    console.error(error.message);
  }
});

// Create an Event
app.post("/events", async (req, res) => {
  try {
    const {
      event_name,
      attendees_count,
      start_date,
      start_time,
      end_time,
      location,
      description,
    } = req.body;

    const start_time_date = new Date(start_date + " " + start_time + ":00");
    const end_time_date = new Date(start_date + " " + end_time + ":00");

    const newEvent = await pool.query(
      `INSERT INTO events 
            (event_name, attendees_count, start_time_date, end_time_date, locid, description)
           VALUES ($1, $2, $3, $4, $5, $6) Returning *`,
      [
        event_name,
        attendees_count,
        start_time_date,
        end_time_date,
        location,
        description,
      ]
    );
    res.json(newEvent.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// Add an event if you're a host
app.post("/host_events", async (req, res) => {
  try {
    const {
      event_name,
      attendees_count,
      start_date,
      start_time,
      end_time,
      location,
      description,
    } = req.body;

    const start_time_date = new Date(start_date + " " + start_time + ":00");
    const end_time_date = new Date(start_date + " " + end_time + ":00");

    const newEvent = await pool.query(
      `INSERT INTO events 
              (event_name, attendees_count, start_time_date, end_time_date, event_status, locid, description)
             VALUES ($1, $2, $3, $4, 'pending', $5, $6) Returning *`,
      [
        event_name,
        attendees_count,
        start_time_date,
        end_time_date,
        location,
        description,
      ]
    );
    res.json(newEvent.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// Get all events
app.get("/events", async (req, res) => {
  try {
    const allEvents = await pool.query(`select e.eventid, e.event_name, 
		e.attendees_count, e.event_status,
		to_char(e.start_time_date, 'mm-dd-yyyy') as start_Date,
		to_char(e.start_time_date, 'HH24:mi AM') as start_time,
		to_char(e.end_time_date, 'mm-dd-yyyy') as end_Date,
		to_char(e.end_time_date, 'HH24:mi AM') as end_time,
		l.location_name as location,
		e.description
        from events e inner join locations l on l.locid = e.locid`);

    res.json(allEvents.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// Get all Active Events
app.get("/active_events", async (req, res) => {
  try {
    const allEvents = await pool.query(`select e.eventid, e.event_name, 
		e.attendees_count, e.event_status,
		to_char(e.start_time_date, 'mm-dd-yyyy') as start_Date,
		to_char(e.start_time_date, 'HH24:mi AM') as start_time,
		to_char(e.end_time_date, 'mm-dd-yyyy') as end_Date,
		to_char(e.end_time_date, 'HH24:mi AM') as end_time,
    e.start_time_date,e.end_time_date,
		l.location_name as location,
    l.locid,
		e.description
        from events e inner join locations l on l.locid = e.locid
        where e.event_status = 'active'
        Order by start_Date, start_time`);

    res.json(allEvents.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// Get all Pending Events
app.get("/pending_events", async (req, res) => {
  try {
    const allEvents = await pool.query(`select e.eventid, e.event_name, 
		e.attendees_count, e.event_status,
		to_char(e.start_time_date, 'mm-dd-yyyy') as start_Date,
		to_char(e.start_time_date, 'HH24:mi AM') as start_time,
		to_char(e.end_time_date, 'mm-dd-yyyy') as end_Date,
		to_char(e.end_time_date, 'HH24:mi AM') as end_time,
    e.start_time_date,e.end_time_date,

		l.location_name as location,
    l.locid,
		e.description
        from events e inner join locations l on l.locid = e.locid
        where e.event_status = 'pending'
        Order by start_Date, start_time`);

    res.json(allEvents.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// Get an event
app.get("/events/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const event = await pool.query(
      `select e.eventid, e.event_name, 
      e.attendees_count, e.event_status,
      to_char(e.start_time_date, 'mm-dd-yyyy') as start_Date,
      to_char(e.start_time_date, 'HH24:mi AM') as start_time,
      to_char(e.end_time_date, 'mm-dd-yyyy') as end_Date,
      to_char(e.end_time_date, 'HH24:mi AM') as end_time,
      l.location_name as location,
      e.description
          from events e inner join locations l on l.locid = e.locid
          where e.eventid = $1
          Order by start_Date, start_time`,
      [id]
    );
    res.json(event.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// get the most recent event
app.get("/mostrecentevents", async (req, res) => {
  try {
    const event = await pool.query(`select * from events 
    where eventid = (select max(eventid) from events);`);
    res.json(event.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// Delete an evnet
app.delete("/events/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const deteleEvent = await pool.query(
      "Delete FROM events where eventid = $1",
      [id]
    );
    res.json(`Event Deleted!`);
  } catch (error) {
    console.error(error.message);
  }
});

// Update an Event
app.put("/events/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const {
      event_name,
      attendees_count,
      start_date,
      start_time,
      end_time,
      location,
      description,
    } = req.body;

    const start_time_date = new Date(start_date + " " + start_time + ":00");
    const end_time_date = new Date(start_date + " " + end_time + ":00");

    const editEvent = await pool.query(
      `UPDATE events
      SET 
      event_name = $1,
      attendees_count = $2,
      start_time_date = $3,
      end_time_date = $4,
      locid = $5,
      description = $6 where eventid = $7`,

      [
        event_name,
        attendees_count,
        start_time_date,
        end_time_date,
        location,
        description,
        id,
      ]
    );
    res.json(`Event Updatded!`);
  } catch (error) {
    console.error(error.message);
  }
});

// Approve an Event
app.put("/approve_events/:id", async (req, res) => {
  try {
    const { id } = req.params;

    const approveEvent = await pool.query(
      `UPDATE events
      SET 
      event_status = 'active' where eventid = $1`,
      [id]
    );
    res.json(`Event Approved!`);
  } catch (error) {
    console.error(error.message);
  }
});

//Get all hosts
app.get("/eventhosts", async (req, res) => {
  try {
    const getHosts = await pool.query(`select 
    (u.first_name || ' ' || u.Last_Name) as Host,
    eh.userid
    from users u inner join event_hosts eh on eh.userid = u.userid
    order by u.first_name;`);
    res.json(getHosts.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// get a host for an event
app.get("/event_hosting/:eventid", async (req, res) => {
  try {
    const { eventid } = req.params;
    const getHosts = await pool.query(
      `select
    (u.first_name || ' ' || u.Last_Name) as Host,
    eh.userid, h.eventid
    from users u inner join event_hosts eh on eh.userid = u.userid
    inner join hosts h on h.userid = u.userid
    where h.eventid = $1
    order by u.first_name;`,
      [eventid]
    );
    res.json(getHosts.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// get all admins
app.get("/eventadmins", async (req, res) => {
  try {
    const getHosts = await pool.query(`select 
    (u.first_name || ' ' || u.Last_Name) as Host,
    a.userid
    from users u inner join admins a on a.userid = u.userid
    order by u.first_name;`);
    res.json(getHosts.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// get an admin for an event
app.get("/event_admins/:eventid", async (req, res) => {
  try {
    const { eventid } = req.params;
    const getHosts = await pool.query(
      `select 
    (u.first_name || ' ' || u.Last_Name) as Host,
    a.userid, ad.eventid
    from users u inner join admins a on a.userid = u.userid
    inner join administrates ad on ad.userid = u.userid
    where ad.eventid = $1
    order by u.first_name;`,
      [eventid]
    );
    res.json(getHosts.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// Insert a host
app.post("/hosts", async (req, res) => {
  try {
    const { host } = req.body;
    const { event } = req.body;
    const assignHost = await pool.query(
      `INSERT INTO Hosts Values ($1, $2) Returning *`,
      [host, event]
    );
    res.json(assignHost.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// Insert an administrator
app.post("/administrates", async (req, res) => {
  try {
    const { admin } = req.body;
    const { event } = req.body;
    const assignAdmin = await pool.query(
      `INSERT INTO Administrates Values ($1, $2) Returning *`,
      [admin, event]
    );
    res.json(assignAdmin.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// ====LOOK AT THIS SOME MORE======

// Create a task
app.post("/tasks", async (req, res) => {
  try {
    const { task_name, assigned_by, assigned_to, duedate, description } =
      req.body;

    const addTask = await pool.query(
      `INSERT INTO Tasks 
      (task_name, assigned_by_userid, assigned_to_userid, duedate, description)
      VALUES ($1, $2, $3, $4, $5) returning *`,
      [task_name, assigned_by, assigned_to, duedate, description]
    );
    res.json(addTask.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// Get a task
app.get("/tasks/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const getTask = await pool.query(`Select * from tasks WHERE taskid = $1`, [
      id,
    ]);
    res.json(getTask.rows[0]);
  } catch (error) {
    console.error(error.message);
  }
});

// Get all tasks
app.get("/tasks", async (req, res) => {
  try {
    const allTasks = await pool.query("select * from tasks");
    res.json(allTasks.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// Get all incomplete tasks
app.get("/incompletetasks", async (req, res) => {
  try {
    const allIncompletetasks = await pool.query(`
        SELECT (u.first_name || ' ' || u.Last_Name) as Assigned_By, t.taskid,
        t.task_name,
        (u2.first_name || ' ' || u2.Last_Name) as Assigned_To,
        to_char(t.assigned_date_time, 'dd-MON-yyyy') as assigned_on,
        to_char(t.duedate, 'dd-MON-yyyy') as due_date
        FROM tasks t INNER JOIN users u on u.userid = t.assigned_by_userid  
        Inner JOIN users u2 on u2.userID = t.assigned_to_userid
        where t.task_name IS NOT NULL and t.completed_date_time is NULL
        order by duedate`);

    res.json(allIncompletetasks.rows);
  } catch (error) {
    comsole.error(error.message);
  }
});

// Get all incomplete tasks for an event
app.get("/incompletetasks/:eventid", async (req, res) => {
  try {
    const { eventid } = req.params;
    const allIncompletetasks = await pool.query(
      `
        SELECT (u.first_name || ' ' || u.Last_Name) as Assigned_By, t.taskid,
        t.task_name,
        (u2.first_name || ' ' || u2.Last_Name) as Assigned_To,
        to_char(t.assigned_date_time, 'dd-MON-yyyy') as assigned_on,
        to_char(t.duedate, 'dd-MON-yyyy') as due_date
        FROM tasks t INNER JOIN users u on u.userid = t.assigned_by_userid  
        Inner JOIN users u2 on u2.userID = t.assigned_to_userid
        inner join associated_with aw on aw.taskid = t.taskid
        where t.task_name IS NOT NULL and t.completed_date_time is NULL
        and aw.eventid = $1
        order by duedate`,
      [eventid]
    );

    res.json(allIncompletetasks.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// Get all complete tasks
app.get("/completetasks", async (req, res) => {
  try {
    const allCompletetasks = await pool.query(`
      SELECT (u.first_name || ' ' || u.Last_Name) as Completed_by, t.taskid,
      t.task_name,    
      to_char(t.completed_date_time, 'dd-MON-yyyy') as completed_on
      FROM tasks t Inner JOIN users u on u.userID = t.assigned_to_userid    
      where t.task_name IS NOT NULL and t.completed_date_time is NOT NULL;`);

    res.json(allCompletetasks.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// Get all complete tasks for an event
app.get("/completetasks/:eventid", async (req, res) => {
  try {
    const { eventid } = req.params;
    const allCompletetasks = await pool.query(
      `
      SELECT (u.first_name || ' ' || u.Last_Name) as Completed_by, t.taskid,
      t.task_name,    
      to_char(t.completed_date_time, 'dd-MON-yyyy') as completed_on
      FROM tasks t Inner JOIN users u on u.userID = t.assigned_to_userid 
      inner join associated_with aw on aw.taskid = t.taskid   
      where t.task_name IS NOT NULL and t.completed_date_time is NOT NULL and
      aw.eventid = $1;`,
      [eventid]
    );

    res.json(allCompletetasks.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// Update a task
app.put("/tasks/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const { task_name, assigned_by, assigned_to, duedate, description } =
      req.body;

    const updateTask = await pool.query(
      `Update tasks
      SET
      task_name = $1,
      assigned_by_userid = $2,
      assigned_to_userid = $3,
      duedate = $4,
      description = $5 where taskid = $6`,
      [
        task_name,
        await fetch(`http://localhost:8000/users/${assigned_by}`)
          .then((res) => res.json())
          .then((data) => data.userid),
        await fetch(`http://localhost:8000/users/${assigned_to}`)
          .then((res) => res.json())
          .then((data) => data.userid),
        duedate,
        description,
        id,
      ]
    );
    res.json("Task Updated!");
  } catch (error) {
    console.error(error.message);
  }
});

//Get aan incomplete Tasks
app.get("/incompletetasks/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const getTask = await pool.query(
      `Select * from tasks
         WHERE taskid = $1 and completed_date_time is Null`,
      [id]
    );
    res.json(getTask.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// Complete an incomplete Task
app.put("/incompletetasks/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const completeTheTask = await pool.query(
      `update tasks
    SET completed_date_time = CURRENT_TIMESTAMP where taskid = $1`,
      [id]
    );
    res.json("Task Completed!");
  } catch (error) {
    console.error(error.message);
  }
});
// Insert into the associated with table
app.post("/associated_with", async (req, res) => {
  try {
    const { eventid } = req.body;

    const addFeatureTaskSatisfaction = await pool.query(
      `Insert Into associated_with
    Values ($1, (select max(taskid) from tasks))`,
      [eventid]
    );
    res.json(addFeatureTaskSatisfaction.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// Insert into the satisfies table
app.post("/satisfies", async (req, res) => {
  try {
    const { featureid, quantity } = req.body;

    const addFeatureTaskSatisfaction = await pool.query(
      `Insert Into satisfies
    Values ((select max(taskid) from tasks), $1, $2)`,
      [featureid, quantity]
    );
    res.json(addFeatureTaskSatisfaction.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// Get all Event Features
app.get("/features", async (req, res) => {
  try {
    const allFeatures = await pool.query(
      "select * from features order by feature_name asc"
    );
    res.json(allFeatures.rows);
  } catch (error) {
    console.error(error.message);
  }
});

app.get("/tasktype", async (req, res) => {
  try {
    const allTaskType = await pool.query("select * from Task_Type");
    res.json(allTaskType.rows);
  } catch (error) {
    console.error(error.message);
  }
});

app.get("/company", async (req, res) => {
  try {
    const allVendors = await pool.query(
      "select * from Business_Contacts bc, Company c WHERE bc.companyID = c.companyID"
    );
    res.json(allVendors.rows);
  } catch (error) {
    console.error(error.message);
  }
});

app.get("/mostrecenttask", async (req, res) => {
  try {
    const task = await pool.query(
      `select * from Tasks where taskID = (select max(taskID) from Tasks)`
    );
    res.json(task.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// Create an Event Feature
app.post("/features", async (req, res) => {
  try {
    const { feature_name, description } = req.body;

    const newEventFeature = await pool.query(
      `INSERT INTO features 
            (feature_name, description)
           VALUES ($1, $2) Returning *`,
      [feature_name, description]
    );
    res.json(newEventFeature.rows);
  } catch (error) {
    console.error(error.message);
  }
});

// Update an event feature
app.put("/features/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const { feature_name, description } = req.body;

    const editEventFeature = await pool.query(
      `UPDATE features
      SET 
      feature_name = $1,
      description = $2 where featureid = $3`,
      [feature_name, description, id]
    );
    res.json(`Event Feature Updated!`);
  } catch (error) {
    console.error(error.message);
  }
});

// Delete an event feature
app.delete("/features/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const deteleEvent = await pool.query(
      "Delete FROM features where featureid = $1",
      [id]
    );
    res.json(`Event Feature Deleted!`);
  } catch (error) {
    console.error(error.message);
  }
});

//______________________________________________________________________________________________________________________

//This is where things start going badly
//Working calls are above the line, these are bad

app.post("/assignFeatureToEvent", async (req, res) => {
  // await
  try {
    const { eventID } = req.body;
    const { taskID } = req.body;
    const assignFeatureToEvent = await pool.query(
      "INSERT INTO Associated_with (eventID, taskID)\
            VALUES($1, $2)\
            RETURNING *",
      [eventID, taskID]
    );
    res.json(assignFeatureToEvent.rows[0]);
  } catch (err) {
    console.error(err.message);
  }
});

app.listen(8000, () => {
  console.log("server has started");
});
