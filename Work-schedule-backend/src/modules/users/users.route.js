const router = require('express').Router();
const users = require('../users/users.controller.js');

router.post('/auth/register', users.register);
router.post('/auth/login', users.login);
router.get('/users', users.getAllUsers);
router.get('/users/:id', users.getUserById);
router.patch('/users/:id', users.updateUserById);
router.delete('/users/:id', users.deleteUserById);

module.exports = router;