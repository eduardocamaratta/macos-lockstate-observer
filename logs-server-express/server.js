#!/usr/bin/env node

// https://superuser.com/questions/536804/cant-run-node-js-script-with-launchd-on-mac
// PATH didn't work, script doesn't seem to be executed, I guess node is failing to start

// try either admin suggestion or maybe converting it to binary (official way or alternative?)
// the import statement doesn't work on binary
// trying require, but then it doesn't work because package.json has type module, removing it
// "type": "module",
// it doesn't work because express isn't a built-in module. they suggest using createRequire()
// also doesn't work but I think I don't know how to use it... try to fix it or look for alternatives
// try to bundle it with esbuild: npx esbuild server.js --bundle --platform=node --outfile=server-bundled.cjs
// adjusted sea-config.json to point to the bundled file
// node --experimental-sea-config sea-config.json
// cp $(which node) node-bin # for bash
// cp (which node) node-bin # for fish
// codesign --remove-signature node-bin
// npx postject node-bin NODE_SEA_BLOB sea-prep.blob \
//     --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2 \
//     --macho-segment-name NODE_SEA
// codesign --sign - node-bin
// this worked! binary size is massive though, plist would have to be updated, and ideally a script to automate the process should be created
// https://nodejs.org/api/single-executable-applications.html

// import express from 'express'
const express = require('express');
// import fs from 'fs'
const fs = require('fs');

// Parse mandatory argument
if (process.argv.length < 3) {
    console.log("Error: missing mandatory argument");
    console.log(`Usage: node ${process.argv[0]} <full_path_to_log_file>`);
    process.exit(1);
}
const logFilePath = process.argv[2];

// Verify that the log file exists
if (!fs.existsSync(logFilePath)) {
    console.log(`Error: File ${logFilePath} not found`);
    process.exit(1);
}

// Read the log file
function readLockUnlockLogFile() {
    try {
        const data = fs.readFileSync(logFilePath, { encoding: 'utf8' });
        return data.split("\n").reverse().join("\n");
    } catch (err) {
        console.error(err);
        return "";
    }
}

// Initialize the server
const app = express();

// Handle errors
app.use(function(err, req, res, next) {
    console.log(err.stack);
    res.status(500).send('Something broke!');
});

// Handle /logs route
app.get("/logs", (req, res) => {
    console.log("info", "Request received: ", req.route.path);
    const logFile = readLockUnlockLogFile();
    res.header("Access-Control-Allow-Origin", "https://timecontrol.firebaseapp.com");
    res.send(logFile);
});

// Start the server
app.listen(7654, function() { console.log("Server is up and running"); });
