const express = require('express');
const router = express.Router();
const multer = require('multer');
const path = require('path');
const mime = require('mime-types');
const {addAProduct,updateAProduct,getProducts,deleteProduct,getAllProducts, getProductsByCategory, getSearchResults,updateImage} = require('../controllers/productController');


const storage = multer.diskStorage({
    destination: (req,file,cb)=>{
        cb(null, path.join(__dirname, '../uploads'));
    },
    filename : (req,file,cb)=>{
        const ext = path.extname(file.originalname);
        cb(null, `${Date.now()}${ext}`);
    }

});

const upload = multer({storage});


router.route("/add/").post(upload.single('image'), addAProduct);

router.route("/updateImage/").put(upload.single('image'), updateImage);

router.route("/updateAProduct/:id").put(updateAProduct);

router.route("/getProducts/:storeID").get(getProducts);

router.route("/deleteProduct/:productID").delete(deleteProduct);

router.route("/getAllProducts").get(getAllProducts);

router.route("/getProductsByCategory/:categoryID").get(getProductsByCategory);

router.route("/getSearchResults/:word").get(getSearchResults);




module.exports = router;