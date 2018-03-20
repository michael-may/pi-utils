/**
 * Node modules
 */
let express = require('express');
let bodyParser = require('body-parser');

/**
 * Local deps
 */
let wifiController = require('./controllers/wifi.controller');

let app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Express middleware for options requests
app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Methods', 'POST,OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Access-Control-Allow-Headers');

    if (req.method === 'OPTIONS') {
        return res.status(200).end();
    }

    next();
});

// Express middleware for CORS headers
app.use((req, res, next) => {
	res = res.header('Access-Control-Allow-Origin', req.headers.origin);
	next();
});

app.post('/wifi/set', wifiController.set);
app.get('/wifi/scan', wifiController.scan);

app.use(express.static('www'));

app.use((req, res) => {
    res.redirect(301, '/');
});

let server = app.listen(8080, () => {
	//console.log('Server started.');
});