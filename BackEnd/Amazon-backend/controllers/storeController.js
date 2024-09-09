const mysql = require('mysql2');

const pool = mysql.createPool({
    host : 'localhost',
    user : 'root',
    password : '',
    database : 'amazon_clone'
})


const getStore = (req,res)=>{

    const StoreID = req.params.storeID;

    pool.query('SELECT * FROM store WHERE StoreID = ?',[StoreID],(err,result)=>{

        if(err){
            return res.status(500).json({'err':err.message});
        }

        return res.status(200).json({
            'success':true,
            'message':"Details for the required store",
            'data':result
        });

    })

}


module.exports = {getStore};