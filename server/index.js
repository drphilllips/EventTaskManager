const express = require("express");
const app = express();
const cors = require("cors");
const pool = require("./db");

app.use(cors());
app.use(express.json());

// ROUTES //

// Login with email and password
app.get("/users?:email&:password")

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

app.listen(5000, () => {
  console.log("Server has started on port 5000");
});
