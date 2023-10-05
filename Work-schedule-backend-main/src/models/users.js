const db = require("../configs/db.js");
const bcrypt = require("bcrypt");
const mongoose = require("mongoose");
const { Schema } = mongoose;

const userSchema = new Schema({
    email: {
        type: String,
        required: true,
        unique: true,
        match: [
            /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/,
            "Email format is not correct!"
        ],
    },
    password: {
        type: String,
        required: true
    },
},{timestamps:true,});

userSchema.pre("save", async function(){
    const user = this;
    try {
        const salt = await bcrypt.genSalt(10);
        const hash = await bcrypt.hash(user.password, salt);
        user.password = hash
    } catch (error) {
        throw error;
    }
})

const userModel = db.model('users', userSchema);
module.exports = userModel;