const Pool = require("pg").Pool;

const pool = new Pool({
  user: "postgres",
  password: "TEbctw#1",
  host: "localhost",
  database: "Event Planner",
  port: 5432,
});

module.exports = pool;
