const express = require('express');

const path = require('path');
require('dotenv').config();
//app express
const app = express();
//servidor de sockets Node serve

const server = require('http').createServer(app);
module.exports.io = require('socket.io')(server);
require('./sockets/sockets');



// server.listen(3000);

//
const publicPath = path.resolve(__dirname, 'public');



app.use(express.static(publicPath));

server.listen(process.env.PORT, (error) => {

    if (error) throw new Error(error);
    console.log('servidor corriendo en puerto!!!',process.env.PORT);
});