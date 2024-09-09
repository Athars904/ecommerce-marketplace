const mysql = require('mysql2');

const pool = mysql.createPool({
    host : 'localhost',
    user : 'root',
    password : '',
    database : 'amazon_clone'
})

const addCartItem = (req,res)=>{

    const data = req.body;
    const customer = data.customerID;
    const product = data.productID;
    const quantity = data.quantity;

    pool.query('INSERT INTO cart_items (CustomerID,ProductID,Quantity) VALUES (?,?,?)',[customer,product,quantity],(err,result)=>{

        if(err){
            return res.status(500).json({'err':err.message});

        }

        return res.status(201).json({
            'success':true,
            'message':'Item successfully added to cart'
        });

    })

};

const getCartItems = (req,res)=>{

    const customerID = req.params.customerID;

    const query = `
    SELECT product.ProductID,product.Name,product.Price,cart_items.Quantity as Quantity ,product.StockQuantity, product.StoreID,product.CategoryID,product.Description,product.Image from product JOIN cart_items on product.ProductID = cart_items.ProductID WHERE CustomerID = ?;
    `;

    pool.query(query,[customerID],(err,result)=>{
        if(err){
            return res.status(500).json({'err':err.message});
        }

        return res.status(200).json({
            'success':true,
            'message' : 'successfuly got all the cart items',
            'data':result
        });
    })





};


const deleteCartItem = (req,res)=>{

    const productID = req.params.productID;

    pool.query('DELETE FROM cart_items WHERE ProductID = ?',[productID],(err,result)=>{

        if(err){
            return res.status(500).json({'err':err.message});
        }

        return res.status(204).json({
            'success':true,
            'messsage':'successfully deleted desired product from cart'
        });
    })
};


const getSubTotal = (req,res)=>{

    const customerID = req.params.customerID;

    const query = `
    SELECT
        SUM(product.Price * cart_items.Quantity) AS TotalSum
    FROM 
        cart_items
    JOIN 
        product ON product.ProductID = cart_items.ProductID

    WHERE 
        cart_items.CustomerID=3
    `;

    pool.query(query,[customerID],(err,result)=>{
        if(err){
           return res.status(500).json({'err':err.message});
        }

        return res.status(200).json({
            'success':true,
            'message':'Sub-total for the cart',
            'data':result
        });


    })


}

module.exports = {addCartItem,getCartItems,deleteCartItem,getSubTotal};