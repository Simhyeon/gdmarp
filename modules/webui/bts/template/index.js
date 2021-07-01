function addCallback(triggerId, eventType, callback) {
	document.getElementById(triggerId).addEventListener(eventType, callback);
}

function addProperties(id, props) {
	let elem = document.getElementById(id);
	for (key in props) {
		elem.setAttribute(key, props[key]);
	}
}

function toggleElement(id) {
	let elem = document.getElementById(id);
	// Enabled
	if (elem.getAttribute("disabled") == null) {
		console.log("Disabled");
		elem.classList.add("disabled");
		elem.disabled = true;
	} 
	// Disabled
	else {
		console.log("Enabled");
		elem.classList.remove("disabled");
		elem.disabled = false;
	}
}

// TODO Make sync value function
function syncValue(id, ev) {

}
