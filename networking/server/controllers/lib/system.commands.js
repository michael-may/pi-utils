let exec = require('child_process').exec;

module.exports = {
	reboot: reboot,
	disableDNSMasq: disableDNSMasq
};

function reboot() {
	execute('shutdown -r now', function(callback){
		console.log(callback);
	});
}

function disableDNSMasq() {
	execute('sudo systemctl disable dnsmasq', function(callback) {
		console.log(callback);
	});
}

function execute(command, callback){
	exec(command, function(error, stdout, stderr){ callback(stdout); });
}
