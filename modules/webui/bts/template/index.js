function addCallback(triggerId, eventType, callback) {
	document.getElementById(triggerId).addEventListener(eventType, callback);
}

function setProperties(id, props) {
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

function syncValue(id, ev) {
	let elem = document.getElementById(id);
	elem.textContent = ev.target.value;
}

function triggerEvent(id, eventType) {
	let elem = document.getElementById(id);
	elem.dispatchEvent(new Event(eventType, { 'bubbles': true }))
}

function callModal(id) {
	let elem = document.getElementById(id);
	let modal = new bootstrap.Modal(elem, {keyboard: false});
	modal.show();
}

function hideModal(caller) {
	let elem = document.querySelector("#" + caller.id + " .modal-close")
	elem.dispatchEvent(new Event('click'), {'bubbles': true})
}
