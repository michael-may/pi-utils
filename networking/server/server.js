/**
 * Node modules
 */
let express = require('express');

/**
 * Local deps
 */
let wifiController = require('./controllers/wifi.controller');

let app = express();

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

let server = app.listen(80, () => {
	//console.log('Server started.');
});