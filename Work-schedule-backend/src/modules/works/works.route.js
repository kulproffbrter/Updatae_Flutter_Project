const router = require('express').Router();
const works = require('../works/works.controller.js');

router.post('/works/create', works.createWork);
router.get('/works', works.getAllWorks);
router.get('/works/:id', works.getWorkById);
router.patch('/works/:id', works.updateWorkById);
router.patch('/works/:id/status', works.updateWorkStatusById);
router.delete('/works/:id', works.deleteWorkById);

module.exports = router;