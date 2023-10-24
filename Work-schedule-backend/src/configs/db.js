const mongoose = require("mongoose");

const connnection = mongoose.createConnection(`mongodb+srv://nbu:nbu65@cluster0.glerzu7.mongodb.net/work-schedule`).on('open', () => {
    console.log('Database Connected');
}).on('error', () => {
    console.log(501);
});

module.exports = connnection;