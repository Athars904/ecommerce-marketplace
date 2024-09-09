const express = require('express');
const router = express.Router();
const {getAllOrders,getOrderDetails,setOrderStatus,setDateDelivered,deleteOrder,placeOrder, getCustomerOrders, getTotalUnits, getTodaysUnits, get6Units} = require('../controllers/orderController');

router.route('/getAllOrders/:storeID').get(getAllOrders);

router.route('/getOrderDetails/:orderID').get(getOrderDetails);

router.route('/setOrderStatus/:OrderID').put(setOrderStatus);

router.route('/setDateDelivered/:OrderID').put(setDateDelivered);

router.route('/deleteOrder/:orderID').delete(deleteOrder);

router.route('/placeOrder/').post(placeOrder);

router.route('/getCustomerOrders/:customerID').get(getCustomerOrders);

router.route('/getTotalUnits/:storeID').get(getTotalUnits);

router.route('/getTodaysUnits/:storeID').get(getTodaysUnits);

router.route('/get6Units/:storeID').get(get6Units);





module.exports = router;
