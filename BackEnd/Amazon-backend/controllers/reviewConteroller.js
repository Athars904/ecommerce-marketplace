const mysql = require('mysql2');

const pool = mysql.createPool(
    {
        host:'localhost',
        user:'root',
        password:'',
        database:'amazon_clone'
    }
);

const getAllReviews = (req,res)=>{

    const storeID = req.params.storeID;
    const query = `
  SELECT customer.Name AS CustomerName, review1.*,DATE_FORMAT(date_created,'%d/%m/%Y') as FormattedDate
FROM customer
JOIN (
    SELECT review.*, product1.ProductName,product1.StoreID
    FROM review 
    JOIN (
        SELECT product.ProductID, product.Name AS ProductName, store.StoreID
        FROM product 
        JOIN store ON product.StoreID = store.StoreID
    ) AS product1 
    ON review.ProductID = product1.ProductID
) AS review1 
ON customer.CustomerID = review1.CustomerID
WHERE StoreID = ?;
`;

    pool.query(query,[storeID],(err,result)=>{
        if(err){
            res.status(500).json({"error":err.message});
        }    

        res.status(200).json({
            "success":true,
            "message":"All reviews for the given store",
            "data":result
        })
    })

}

const getProductReviews = (req,res)=>{

    const productID = req.params.productID;

    const query = `
    SELECT customer.Name AS CustomerName, review1.*,DATE_FORMAT(date_created,'%d/%m/%Y') as FormattedDate
  FROM customer
  JOIN (
      SELECT review.*, product1.ProductName,product1.StoreID
      FROM review 
      JOIN (
          SELECT product.ProductID, product.Name AS ProductName, store.StoreID
          FROM product 
          JOIN store ON product.StoreID = store.StoreID
      ) AS product1 
      ON review.ProductID = product1.ProductID
  ) AS review1 
  ON customer.CustomerID = review1.CustomerID
  WHERE ProductID = ? ;
  `;

    pool.query(query,[productID],(err,result)=>{
            if(err){
                return res.status(500).json({'err':err.message});
            }

            res.status(200).json({
                "success":true,
                "message":"reviews for this product",
                "data":result
            });



    })



}

const dropReview = (req,res)=>{
    const data = req.body;
    const stmt = data.stmt;
    const stars = data.stars;
    const productID = data.productID;
    const customerID = data.customerID;

    pool.query('INSERT INTO review (ReviewStatement,ReviewStars,ProductID,CustomerID) VALUES (?,?,?,?)',[stmt,stars,productID,customerID],(err,result)=>{
        if(err){
            return res.status(500).json({'err':err.message})
        }

        return res.status(201).json({
            'success':true,
            'message':'review successfully dropped'
        })
    })
}

module.exports = {getAllReviews,getProductReviews,dropReview};