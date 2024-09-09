const express = require("express");
const router = express.Router();
const {signup,login,fetchSellerDetails,updateSellerDetails} = require('../controllers/sellerController.js');


router.route('/signup/').post(signup);


router.route('/login/').post(login);

router.route('/fetchSellerDetails/:email').get(fetchSellerDetails);

router.route('/updateSellerDetails/').put(updateSellerDetails);


module.exports = router;

