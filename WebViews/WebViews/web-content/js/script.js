function addLog(text) {
    document.getElementById("contents").innerHTML += text+"<br />";
}

function getLogText() {
    return document.getElementById("contents").innerHTML;
}

function sendMessage() {
    window.webkit.messageHandlers.sendMessage.postMessage("Hi there from javascript");
}
