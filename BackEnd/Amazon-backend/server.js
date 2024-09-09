const express = require('express');
const app = express();
const path = require('path');

const router1 = require('./routes/sellerRoutes');
const router2 = require('./routes/productRoutes');
const router3 = require('./routes/reviewRoutes');
const router4 = require('./routes/orderRoutes');
const router5 = require('./routes/transactionRoutes');
const router6 = require('./routes/customerRoutes');
const router7 = require('./routes/storeRoutes');
const router8 = require('./routes/cartRoutes');
const cors = require('cors');

app.use(cors());
app.use(express.json());

let test = app.use('/uploads', express.static(path.join(__dirname, 'uploads')));



app.use('/seller',router1);

app.use('/product',router2);

app.use('/review',router3);

app.use('/order',router4);

app.use('/transaction',router5);

app.use('/customer',router6);

app.use('/store',router7);

app.use('/cart',router8);





app.listen(3000,()=>{
    console.log('Server running on port 3000');
})
