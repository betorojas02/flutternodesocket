//message the sockets


const Bands = require('../models/bands');

const Band = require('../models/band');
const {io} = require('../index');


const bands = new Bands();


bands.addBand( new Band('QUEEN'));
bands.addBand( new Band('JESUS CULTURE'));
bands.addBand( new Band('LIVING'));
bands.addBand( new Band('G12'));


console.log(bands);




io.on('connection', client => {
    // client.on('event', data => { /* … */ });


    client.emit('active-bands' , bands.getBands());
    console.log('Cliente conectado');
    client.on('disconnect', () => {
        console.log('Cliente desconectado');
    });


    client.on('vote-band' , (payload) => {

        bands.voteBand(payload.id);

        io.emit('active-bands' , bands.getBands()); // con io envio mensaje a todos por que es el servidor

    });

    client.on('add-band' , (payload) => {

        bands.addBand(new Band(payload.name));

        io.emit('active-bands' , bands.getBands()); // con io envio mensaje a todos por que es el servidor

    });

    client.on('delete-band' , (payload) => {

        // bands.addBand(new Band(payload.name));

        bands.deleteBand(payload.id);
        io.emit('active-bands' , bands.getBands()); // con io envio mensaje a todos por que es el servidor

    });

    client.on('emitir-mensaje', (payload)  => {

        console.log(payload);

        client.broadcast.emit('nuevo-mensaje' , payload);
    });
});