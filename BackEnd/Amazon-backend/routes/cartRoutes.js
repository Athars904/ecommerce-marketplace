const express = require('express');
const router = express.Router();
const {addCartItem,getCartItems,deleteCartItem,getSubTotal} = require('../controllers/cartController');

router.route('/addCartItem/').post(addCartItem);

router.route('/getCartItems/:customerID').get(getCartItems);

router.route('/deleteCartItem/:productID').delete(deleteCartItem);

router.route('/getSubTotal/:customerID').get(getSubTotal);


module.exports = router;