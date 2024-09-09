const express = require('express');
const router = express.Router();
const {createTransaction,getAllTransactions, getTodaysAmount, getTotalAmount, get6Units} = require('../controllers/transactionController');


router.route('/createTransaction').post(createTransaction);

router.route('/getAllTransactions/:storeID').get(getAllTransactions);



router.route('/getTodaysAmount/:storeID').get(getTodaysAmount);

router.route('/getTotalAmount/:storeID').get(getTotalAmount);

router.route('/get6Units/:storeID').get(get6Units);


module.exports = router;