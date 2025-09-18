const express = require('express');
const app = express();
app.get('/', (req, res) => res.send('Hello from AWS DevOps Demo with Jenkins + Prometheus!'));
app.listen(80, () => console.log("App running on port 80"));
