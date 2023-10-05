const userService = require('../users/users.service.js');
const bcrypt = require('bcrypt');

const register = async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await userService.createUser({ email, password });
        res.status(201).json({status: true, message: "Register successful"});
    } catch (error) {
        res.status(500).json({status: false, error: error.message });
    }
}

const login = async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await userService.getUserByEmail(email);
        if (!user) {
            res.status(401).json({status: false, error: "Email not found" });
            return;
        }

        const isPasswordValid = await bcrypt.compare(password, user.password);
        if (!isPasswordValid) {
            res.status(401).json({status: false, error: "Incorrect password" });
            return;
        }
        res.status(200).json({status: true, message: "Login successful" });
    } catch (error) {
        res.status(500).json({status: false, error: error.message });
    }
}

const getAllUsers = async (req, res) => {
    try {
        const users = await userService.getUser();
        res.status(200).json({users});
    } catch (error) {
        res.status(500).json({status: false, error: error.message });
    }
}

const getUserById = async (req, res) => {
    try {
        const user = await userService.getUserById(req.params.id);
        if (!user) {
            res.status(404).json({status: false, error: "User not found" });
            return;
        }
        res.status(200).json({user});
    } catch (error) {
        res.status(500).json({status: false, error: error.message });
    }
}

const updateUserById = async (req, res) => {
    try {
        const updatedUser = await userService.updateUserById(req.params.id, req.body);
        if (!updatedUser) {
            res.status(404).json({status: false, error: "User not found" });
            return;
        }
        res.status(200).json({status: true, message: "update successful"});
    } catch (error) {
        res.status(500).json({status: false, error: error.message });
    }
}

const deleteUserById = async (req, res) => {
    try {
        const deletedUser = await userService.deleteUserById(req.params.id);
        if (!deletedUser) {
            res.status(404).json({status: false, error: "User not found" });
            return;
        }
        res.status(204).send({status: true, message: "delete successful"});
    } catch (error) {
        res.status(500).json({status: false, error: error.message });
    }
}

module.exports = {register, login,getAllUsers, getUserById, updateUserById, deleteUserById};