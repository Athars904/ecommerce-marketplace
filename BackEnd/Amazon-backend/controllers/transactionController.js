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

const createTransaction = (req,res)=>{
    const data = req.body;
    const amount = data.amount;
    const details = data.details;
    const date = data.date;
    const orderID = data.orderID;
    const storeID = data.storeID;

    pool.query('INSERT INTO transaction (Amount,Details,Date,OrderID,StoreID) VALUES(?,?,?,?,?)',[amount,details,date,orderID,storeID],(err,result)=>{
        if(err){
            return res.status(500).json({"err":err.message});
        }

        res.status(201).json({
            "success":true,
            "message":"Insertion into transaction successful",

        })
    })
}

const getAllTransactions = (req,res)=>{
    const storeID = req.params.storeID;
    const query = `
    SELECT 
        t.*,
        (SELECT SUM(CAST(t1.Amount AS DECIMAL(10,2))) 
         FROM transaction t1
         WHERE t1.StoreID = t.StoreID) AS TotalAmount,
        DATE_FORMAT(t.Date, '%d/%m/%y') as FormattedDate
    FROM 
        transaction t
    WHERE 
        t.StoreID = ?;
    `;
    

    pool.query(query,[storeID],(err,result)=>{
        if(err){
            return res.status(500).json({'err':err.message});
        }

        res.status(200).json({
            "success":true,
            "message":"successfully fetched all the transactions for this particular store",
            "data":result
        })
    })
};

const getTotalAmount = (req, res) => {
    const storeID = req.params.storeID;

    // SQL Query to get the total amount ever made for the specific store
    const query = `
    SELECT 
        IFNULL(SUM(t.Amount), 0) AS TotalAmount
    FROM 
        transaction t
    WHERE 
        t.StoreID = ?;
    `;

    // Execute the query
    pool.query(query, [storeID], (err, results) => {
        if (err) {
            // Handle SQL errors
            return res.status(500).json({ 'err': err.message });
        }

        // Return the result
        return res.status(200).json({
            'success': true,
            'message': 'Total amount made',
            'data': results // Accessing the first row of the result
        });
    });
};








const getTodaysAmount = (req,res)=>{

    const storeID = req.params.storeID;

    const query = `
    SELECT 
    IFNULL(SUM(t.Amount), 0) AS TotalAmount
FROM 
    transaction t
WHERE 
    t.StoreID = ? AND DATE(t.Date) = CURDATE();

`;

pool.query(query,[storeID],(err,result)=>{

    if(err){
        return res.status(500).json({'err':err.message});
    }

    return res.status(200).json({
        'successs':true,
        'message':'total for today',
        'data':result
    });


})




}


const get6Units = (req,res)=>{

    const storeID = req.params.storeID;

    const query = `

    SELECT 
    SUM(CASE WHEN MONTH(transaction.Date) = MONTH(CURDATE()) THEN Amount ELSE 0 END) AS Month6,
   SUM(CASE WHEN MONTH(transaction.Date) = MONTH(CURDATE() - INTERVAL 1 MONTH) THEN Amount ELSE 0 END) AS Month5,
   SUM(CASE WHEN MONTH(transaction.Date) = MONTH(CURDATE() - INTERVAL 2 MONTH) THEN Amount ELSE 0 END) AS Month4,
   SUM(CASE WHEN MONTH(transaction.Date) = MONTH(CURDATE() - INTERVAL 3 MONTH) THEN Amount ELSE 0 END) AS Month3,
   SUM(CASE WHEN MONTH(transaction.Date) = MONTH(CURDATE() - INTERVAL 4 MONTH) THEN Amount ELSE 0 END) AS Month2,
   SUM(CASE WHEN MONTH(transaction.Date) = MONTH(CURDATE() - INTERVAL 5 MONTH) THEN Amount ELSE 0 END) AS Month1
FROM transaction
 WHERE StoreID = 28;

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



module.exports = {createTransaction,getAllTransactions,getTotalAmount,getTodaysAmount,get6Units};