const { query } = require('express');
const mysql = require('mysql2');

const pool = mysql.createPool(
    {
        host:'localhost',
        user:'root',
        password:'',
        database:'amazon_clone'
    }
);

const getAllOrders = (req,res)=>{

    const storeID = req.params.storeID;

    const query = `
    SELECT
        \`order\`.OrderID,
        \`order\`.status,
        DATE_FORMAT(\`order\`.DateRecieved, '%d/%m/%y') as FormattedDate,
        customer.Name as CustomerName,
        customer.Address as CustomerAddress,
        SUM(product.Price * order_details.Quantity) AS TotalSum
    FROM 
        order_details
    JOIN 
        \`order\` ON \`order\`.OrderID = order_details.OrderID
    JOIN 
        product ON product.ProductID = order_details.ProductID
    JOIN 
        customer ON \`order\`.CustomerID = customer.CustomerID
    WHERE 
        \`order\`.StoreID = ?
    GROUP BY
        \`order\`.OrderID,
        \`order\`.status,
        FormattedDate,
        customer.Name,
        customer.Address
    ORDER BY 
        FormattedDate DESC;
`;


    pool.query(query,[storeID],(err,result)=>{
        if(err){
            res.status(500).json({"err":err.message});
        }

        res.status(200).json({
            "sucess":true,
            "message":"All orders for the current store",
            "data":result


        });


    })
    
    




};

const getOrderDetails = (req,res)=>{
    const orderID = req.params.orderID;

    const query = `
    SELECT 
        product.Name as ProductName ,product.price as ProductPrice,order_details.Quantity as ProductQuantity,product.Image
    FROM 
        product 
    JOIN 
        order_details 
    ON 
        order_details.ProductID = product.ProductID 
    WHERE 
        order_details.OrderID = ?;
`;

    pool.query(query,[orderID],(err,result)=>{
        if(err){
            res.status(500).json({"err":err.message});
        }

        res.status(200).json({
            "success":true,
            "message":"Order-Product details",
            "data":result
        });
    })
  

};


const setOrderStatus = (req,res)=>{
    const OrderID = req.params.OrderID;
    const status = req.body.status;

    if (!OrderID || !status) {
        return res.status(400).json({
            "error": "OrderID and status are required"
        });
    }


    pool.query('UPDATE `order` SET Status = ? WHERE OrderId = ?',[status,OrderID],(err,result)=>{
        if(err){
             return  res.status(500).json({"error":err.message});


        }

        res.status(201).json({
            "success":true,
            "message":"Status changed successfully",
            
        });
    })

} 


const setDateDelivered = (req,res)=>{
    const OrderID = req.params.OrderID;
    const DateDelivered = req.body.DateDelivered;

    pool.query('UPDATE `order` SET DateDelivered = ? WHERE OrderId = ? ',[DateDelivered,OrderID],(err,result)=>{
        if(err){
            return res.status(500).json({"error":err});
        }

        res.status(201).json({
            "success":true,
            "message":"Delivery Date successfully added"
        });
    })
};


const deleteOrder = (req, res) => {
    const orderID = req.params.orderID;

    pool.getConnection((err, connection) => {
        if (err) {
            return res.status(500).json({ 'error': err.message });
        }

        connection.beginTransaction(err => {
            if (err) {
                connection.release();
                return res.status(500).json({ 'error': err.message });
            }

            connection.query('DELETE FROM order_details WHERE OrderID = ?', [orderID], (err, result) => {
                if (err) {
                    return connection.rollback(() => {
                        connection.release();
                        res.status(500).json({ 'error': err.message });
                    });
                }

                connection.query('DELETE FROM transaction WHERE OrderID = ?', [orderID], (err, result) => {
                    if (err) {
                        return connection.rollback(() => {
                            connection.release();
                            res.status(500).json({ 'error': err.message });
                        });
                    }

                    connection.query('DELETE FROM `order` WHERE OrderID = ?', [orderID], (err, result) => {
                        if (err) {
                            return connection.rollback(() => {
                                connection.release();
                                res.status(500).json({ 'error': err.message });
                            });
                        }

                        connection.commit(err => {
                            if (err) {
                                return connection.rollback(() => {
                                    connection.release();
                                    res.status(500).json({ 'error': err.message });
                                });
                            }

                            connection.release();
                            res.status(204).json({
                                'success': true,
                                'message': 'Deleted successfully'
                            });
                        });
                    });
                });
            });
        });
    });
};


const createOrder = async (customerID,storeID,items)=>{

    let orderResult;

    try{

        orderResult = await new Promise((resolve,reject)=>{

            pool.query('INSERT INTO `order` (CustomerID,StoreID) VALUES (?,?)',[customerID,storeID],(err,result)=>{
                if(err){
                    reject(err);
                }

                resolve(result);
            })
        })
        
        
        const orderID = orderResult.insertId;
        // console.log(orderID);

        // let i = 1 ;

        for(const item of items){
            await new Promise((resolve,reject)=>{

            //   console.log(i);
            //   console.log(orderID);
            //   i++;

                pool.query('INSERT INTO order_details (OrderID,ProductID,Quantity) VALUES (?,?,?)',[orderID,item.ProductID,item.Quantity],(err,result)=>{
                    if(err){
                        reject(err);
                    }

                    resolve(result);
                })
            });

            await new Promise((resolve,reject)=>{

                //   console.log(i);
                //   console.log(orderID);
                //   i++;
    
                    pool.query('UPDATE product set StockQuantity = StockQuantity - ? WHERE ProductID = ?',[item.Quantity,item.ProductID],(err,result)=>{
                        if(err){
                            reject(err);
                        }
    
                        resolve(result);
                    })
                })
         }

         await new Promise((resolve,reject)=>{


            pool.query('DELETE FROM cart_items WHERE CustomerID = ?',[customerID],(err,result)=>{

                if(err){
                    reject(err);

                }

                resolve(result)

            })
         })
        
        




    }catch(e){
        return e;
    }
    


}




const placeOrder = async (req, res) => {
    const data = req.body;
    const customerID = data.customerID;

    try {
        // Wrap the pool.query in a Promise
        const results = await new Promise((resolve, reject) => {
            pool.query(
                'SELECT product.StoreID, cart_items.* FROM cart_items JOIN product ON cart_items.ProductID = product.ProductID WHERE cart_items.CustomerID = ?',
                [customerID],
                (err, result) => {
                    if (err) {
                        reject(err);
                    } else {
                        
                        resolve(result);
                    }
                }
            );
        });
        
        // if(Array.isArray(results))
        //     {
        //     console.log("yes i am an array")
        // };


 //   console.log(results);


        // console.log(results);

        const itemsByStore = results.reduce((acc, item) => {
            const { StoreID } = item;
            if (!acc[StoreID]) acc[StoreID] = [];
            acc[StoreID].push(item);
            return acc;
        }, {});

         console.log(itemsByStore);

        
        for (const [storeID, items] of Object.entries(itemsByStore)) {
           // console.log(`Creating order for storeID: ${storeID}, items:`, items);
             await createOrder(customerID,storeID,items);            

        }



        // Send the results back in the response
        return res.status(201).json({
            'success':true,
            'message':'successfully placed order'
        });
    } catch (err) {
        return res.status(500).json({
            error: err.message
        });
    }
};


const getCustomerOrders = (req,res)=>{

    const customerID = req.params.customerID;

    const query = `
    SELECT
        \`order\`.OrderID,
        \`order\`.status,
        DATE_FORMAT(\`order\`.DateRecieved, '%d/%m/%y') as FormattedDate,
        customer.Name as CustomerName,
        customer.Address as CustomerAddress,
        SUM(product.Price * order_details.Quantity) AS TotalSum
    FROM 
        order_details
    JOIN 
        \`order\` ON \`order\`.OrderID = order_details.OrderID
    JOIN 
        product ON product.ProductID = order_details.ProductID
    JOIN 
        customer ON \`order\`.CustomerID = customer.CustomerID
    WHERE 
        customer.CustomerID = ?
    GROUP BY
        \`order\`.OrderID,
        \`order\`.status,
        FormattedDate,
        customer.Name,
        customer.Address
    ORDER BY 
        FormattedDate DESC;
`;


    pool.query(query,[customerID],(err,result)=>{
        if(err){
            res.status(500).json({"err":err.message});
        }

        res.status(200).json({
            "sucess":true,
            "message":"All orders for the current customer",
            "data":result


        });


    })
    
    




};

const getTotalUnits = (req,res)=>{

    const storeID = req.params.storeID;

    const query = `
    SELECT SUM(Quantity) as Total
    from \`order\` JOIN order_details on \`order\`.OrderId = order_details.OrderID 
    Where StoreID = ? AND DateDelivered IS NOT NULL; 
    `
    pool.query(query,[storeID],(err,result)=>{
        if(err){
            return res.status(500).json({'err':err.message});
        }

        return res.status(200).json({
            'success':true,
            'message':'total units ever sold',
            'data':result
        });
    })

}

const getTodaysUnits = (req,res)=>{

    const storeID = req.params.storeID;

    const query = `
    SELECT SUM(order_details.Quantity)  as Total
    from \`order\` JOIN order_details on \`order\`.OrderId = order_details.OrderID 
    Where \`order\`.StoreID = 28 AND DATE(\`order\`.DateDelivered) = curdate() ; 
    `
    pool.query(query,[storeID],(err,result)=>{
        if(err){
            return res.status(500).json({'err':err.message});
        }

        return res.status(200).json({
            'success':true,
            'message':'total units sold today',
            'data':result
        });
    })

}



const get6Units = (req,res)=>{

    const storeID = req.params.storeID;

    const query = `
SELECT 
	 SUM(CASE WHEN MONTH(DateDelivered) = MONTH(CURDATE()) THEN Quantity ELSE 0 END) AS Month6,
    SUM(CASE WHEN MONTH(DateDelivered) = MONTH(CURDATE() - INTERVAL 1 MONTH) THEN Quantity ELSE 0 END) AS Month5,
    SUM(CASE WHEN MONTH(DateDelivered) = MONTH(CURDATE() - INTERVAL 2 MONTH) THEN Quantity ELSE 0 END) AS Month4,
    SUM(CASE WHEN MONTH(DateDelivered) = MONTH(CURDATE() - INTERVAL 3 MONTH) THEN Quantity ELSE 0 END) AS Month3,
    SUM(CASE WHEN MONTH(DateDelivered) = MONTH(CURDATE() - INTERVAL 4 MONTH) THEN Quantity ELSE 0 END) AS Month2,
    SUM(CASE WHEN MONTH(DateDelivered) = MONTH(CURDATE() - INTERVAL 5 MONTH) THEN Quantity ELSE 0 END) AS Month1
FROM \`order\`
JOIN order_details ON \`order\`.OrderID = order_details.OrderID
WHERE DateDelivered >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH) 
  AND StoreID = 28;

    `
    pool.query(query,[storeID],(err,result)=>{
        if(err){
            return res.status(500).json({'err':err.message});
        }

        return res.status(200).json({
            'success':true,
            'message':'total units sold in 6 months',
            'data':result
        });
    })

}













module.exports = {getAllOrders,getOrderDetails,setOrderStatus,setDateDelivered,deleteOrder,placeOrder,getCustomerOrders,getTotalUnits,getTodaysUnits,get6Units};