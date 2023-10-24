const db = require("../configs/db.js");
const mongoose = require("mongoose");
const { Schema } = mongoose;

const workSchema = new Schema({
    headers: {
        type: String,
        required: true,
    },
    description: {
        type: String,
        default: ''
    },
    startDate: {
        type: String,
        required: true,
    },
    endDate: {
        type: String,
        required: true,
    },
    startTime: {
        type: String,
        required: true,
    },
    endTime: {
        type: String,
        required: true,
    },
    workStatus: {
        type: String,
        enum:[, 'In-Progress', 'Done', 'Cancel'],
        default:'In-Progress'
    }
},{timestamps:true,});

const workModel = db.model('works', workSchema);
module.exports = workModel;