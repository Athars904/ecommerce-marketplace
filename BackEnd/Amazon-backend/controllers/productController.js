const mysql = require('mysql2');
const path = require('path');

const pool = mysql.createPool({
    host : 'localhost',
    user : 'root',
    password : '',
    database : 'amazon_clone'
})


const addAProduct = (req,res)=>{

    const data = req.body;
    const name = data.name;
    const price = parseInt(data.price);
    const stock = parseInt(data.quantity);
    const storeID = parseInt(data.store);
    const categoryID = parseInt(data.category);
    const description = data.description;
    const imagePath = path.relative(__dirname, req.file.path); 

    const normalizedImagePath = imagePath.replace(/\\/g, '/');


    pool.query("INSERT INTO product (Name,Price,StockQuantity,StoreID,CategoryID,Description,Image) VALUES (?,?,?,?,?,?,?)",[name,price,stock,storeID,categoryID,description,normalizedImagePath],(err,result)=>{
        if(err){
            console.log(err.message);
            return res.status(500).json({'error':err.message});
        }

        return res.status(201).json({"message":"successful"});
    })


}

const updateImage = (req,res)=>{
    const data = req.body;
    const productID = parseInt(data.productID);
    const imagePath = path.relative(__dirname,req.file.path);

    const normalizedImagePath = imagePath.replace(/\\/g, '/');


    pool.query('UPDATE product SET Image = ? WHERE ProductID = ?',[normalizedImagePath,productID],(err,result)=>{
        if(err){
                 return res.status(500).json({'error':err.message});

        }

        return res.status(201).json({"message":"successful"});


    })


}

const updateAProduct = async (req,res)=>{

    const id = req.params.id;
    const data = req.body;
    const name = data.name;
    const price = data.price;
    const stock = data.quantity;
    const category = data.category;
    const description = data.description;


    try{
        if(name!= null && name!=''){
            await new Promise((resolve,reject)=>{
                pool.query("UPDATE product SET Name = ? WHERE ProductID = ?",[name,id],(err,result)=>{
                     if(err){
                        return reject(err);
                     }   

                     resolve(result);
                })    
            })
        }


        if(price!= null && price!='' && price != 0){
            await new Promise((resolve,reject)=>{
                pool.query("UPDATE product SET Price = ? WHERE ProductID = ?",[price,id],(err,result)=>{
                     if(err){
                        return reject(err);
                     }   

                     resolve(result);
                })    
            })
        }

        if(stock!= null && stock!='' && stock != 0){
            await new Promise((resolve,reject)=>{
                pool.query("UPDATE product SET StockQuantity = ? WHERE ProductID = ?",[stock,id],(err,result)=>{
                     if(err){
                        return reject(err);
                     }   

                     resolve(result);
                })    
            })
        }

        if(category!= null && category!='' && category != 0){
            await new Promise((resolve,reject)=>{
                pool.query("UPDATE product SET CategoryID = ? WHERE ProductID = ?",[category,id],(err,result)=>{
                     if(err){
                        return reject(err);
                     }   

                     resolve(result);
                })    
            })
        }

        if(description!= null && description!='' && description != 0){
            await new Promise((resolve,reject)=>{
                pool.query("UPDATE product SET Description = ? WHERE ProductID = ?",[description,id],(err,result)=>{
                     if(err){
                        return reject(err);
                     }   

                     resolve(result);
                })    
            })
        }

        res.status(201).json({
            "success":true,
            "message":"update successful"});



    }catch(err){
        res.status(400).json({"err":err.message});
    }




}


const getProducts = (req,res)=>{

    const storeID = req.params.storeID;

    pool.query("SELECT * FROM product WHERE StoreID = ? ",[storeID],(err,result)=>{

        if(err){
            res.status(500).json({"error":err.message});
        }


        res.status(200).json({
            "success":true,
            "message":"All products of the store",
            "data":result    
        }
        );


    }
)

}

const deleteProduct = (req,res)=>{
    const productID = req.params.productID;

    pool.query("DELETE FROM product WHERE ProductID = ? ",[productID],(err,result)=>{
        if(err){
            res.status(500).json({"error":err.message});
        }

        res.status(204).json({
            "success":true,
            "message":"deleted successfully"
        });


    })


}

const getAllProducts = (req,res)=>{

    pool.query("SELECT * from Product",(err,result)=>{
        if(err){
            return res.status(500).json({"error":err.message});
        }

        return res.status(200).json({
            "success":true,
            "message":"All the products fetched",
            "data":result
        })
    })


}

const getProductsByCategory = (req,res)=>{
    const categoryID = req.params.categoryID;

    pool.query('SELECT * FROM product WHERE CategoryID = ?',[categoryID],(err,result)=>{
        if(err){
            return res.status(500).json({'err':err.message});
        }
        
        return res.status(200).json({
            'success':true,
            'message':'all products in this category',
            'data':result
        });

    })
}

const getSearchResults = (req,res)=>{
    const word = req.params.word;
    const query = `SELECT * FROM product WHERE Name LIKE '%${word}%'`;


    pool.query(query,(err,result)=>{
        if(err){
            return res.status(500).json({'error':err.message});
        }

        return res.status(200).json({
            'success':true,
            'message':'search results',
            'data':result
        })
    })
}

module.exports = {addAProduct,updateAProduct,getProducts,deleteProduct,getAllProducts,getProductsByCategory,getSearchResults,updateImage};