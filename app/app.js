const express = require('express');
const bodyParser = require('body-parser');
const app = express();

// Middleware to parse form data
app.use(bodyParser.urlencoded({ extended: true }));

// Hardcoded credentials
const Email = "hire-me@anshumat.org";
const PASSWORD = "HireMe@2025";

// Root route
app.get('/status', (req, res) => {
  res.send('Hello from AWS DevOps Demo with Jenkins + Prometheus!');
});

// Serve login page
app.get('/', (req, res) => {
  res.send(`
    <h2>Login Page</h2>
    <form method="POST" action="/login">
      <label>Email:</label>
      <input type="text" name="Email" required />
      <br><br>
      <label>Password:</label>
      <input type="password" name="password" required />
      <br><br>
      <button type="submit">Login</button>
    </form>
  `);
});

// Handle login
app.post('/login', (req, res) => {
  const { Emailmail, password } = req.body;

  if (Email === Email && password === PASSWORD) {
    res.send(`<h3>✅ Login successful! Welcome, ${Email}.</h3>
      <p>Hello from AWS DevOps Demo with Jenkins</p>
    `);
    
  } else {
    res.send(`<h3>❌ Invalid username or password. Try again <a href="/login">here</a>.</h3>`);
  }
});

// Start server
app.listen(8082, () => console.log("App running on port 8082"));
