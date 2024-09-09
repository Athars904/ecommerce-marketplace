const express = require("express");
const router = express.Router();
const {signup,login,fetchCustomerDetails, updateCustomerDetails} = require('../controllers/customerController');

router.route('/signup/').post(signup);

router.route('/login/').post(login);

router.route('/fetchCustomerDetails/:email').get(fetchCustomerDetails);

router.route('/updateCustomerDetails').put(updateCustomerDetails);

module.exports = router;