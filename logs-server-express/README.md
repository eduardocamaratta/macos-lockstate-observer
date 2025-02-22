# Local express server

In order to access the current content of the log file through a webpage, as a temporary measure, it's possible to locally install an express server that provides the logs in response to a GET request to /logs on port 7654. The file is returned as-is and any extra processing must be performed by the caller.

## Installation

1. Make sure a recent version of node is installed (preferrably install it using a version manager like NVM).
2. On the `logs-server` folder run npm install.
3. Edit %NODE_LOCATION%, %SCRIPT_LOCATION% and %LOGS_FILE_LOCATION% on com.eduardocamaratta.lockstateserver.plist
4. Copy the plist to $HOME/Library/LaunchAgents
5. Load the plist with `launchctl load ~/Library/LaunchAgents/com.eduardocamaratta.lockstateserver.plist`
6. Start the server with `launchctl start com.eduardocamaratta.lockstateserver`

## Usage

Once the server is running, it's possible to fetch the logs with (via node or browser):
```javascript
fetch('http://127.0.0.1:7654/logs').then(response => response.text()).then(t => console.log(t))
```

*On Brave browser had to disable the Shields for the website making the request, because the local url was being treated as tracker (or ad).