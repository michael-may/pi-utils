/**
 * Node modules
 */
let fs = require('fs');
let wifiscanner = require('node-wifiscanner');

/**
 * Local deps
 */
let sysCmd = require('./lib/system.commands');

module.exports = {
	scan: scan,
	set: set
};

function scan(req, res) {
	try {
		// Write to Javascript
		wifiscanner.scan((err, data) => {
			if (err) {
				res.send({
					message: err,
					status: 'error'
				});
				return;
			}

			res.send({
				data: data.filter(uniqFilterAccordingToProp('ssid')),
				status: 'success'
			});
		});
	}
	catch(err) {
		res.send({
			message: err,
			status: 'error'
		});
	}
}

function set(req, res) {
	try {
		let txt = `
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=GB

network={
		ssid="${req.body.ssid}"
		psk="${req.body.password}"
}
		`;

		fs.writeFile('/etc/wpa_supplicant/wpa_supplicant.conf', txt, (err) => {  
			// throws an error, you could also catch it here
			if (err) throw err;

			// success case, the file was saved
			res.send({
				status: 'success',
				message: 'Wifi saved successfully!'
			});
			sysCmd.disableDNSMasq();
			setTimeout(() => sysCmd.reboot(), 5000);
		});
		
	}
	catch(err) {
		res.send({
			message: err,
			status: 'error'
		});
	}
}

function uniqFilterAccordingToProp(prop) {
	if (prop) {
		return (ele, i, arr) => arr.map(ele => ele[prop]).indexOf(ele[prop]) === i;
	} else {
		return (ele, i, arr) => arr.indexOf(ele) === i;
	}
}