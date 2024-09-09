const express = require('express');
const router = express.Router();
const {getAllReviews, getProductReviews, dropReview} = require('../controllers/reviewConteroller');



router.route("/getAllReviews/:storeID").get(getAllReviews);

router.route("/getProductReviews/:productID").get(getProductReviews);


router.route("/dropReview/").post(dropReview);

module.exports = router;