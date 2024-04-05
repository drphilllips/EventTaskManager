import React, { useState } from "react";

function Login() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const onSubmitForm = async (e) => {
    e.preventDefault();
    try {
      const response = await fetch(`http://localhost:5000/users?${email}&${password}`);
      const jsonData = await response.json();
      console.log(jsonData);
    } catch (err) {
      console.error(err.message);
    }
  };

  return (
    <div>
      <h2>Login</h2>
      <form onSubmit={onSubmitForm}>
        <input
          type="email"
          placeholder="Email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
        />
        <input
          type="password"
          placeholder="Password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          required
        />
        <button type="submit">Login</button>
      </form>
    </div>
  );
}

export default Login;
