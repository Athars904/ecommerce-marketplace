const mysql = require('mysql2');
const pool = mysql.createPool({
    host : 'localhost',
    user : 'root',
    password : '',
    database : 'amazon_clone'
});


const signup = (req,res)=>{

    const data = req.body;
    const email = data.email;
    const name = data.name;
    const address = data.address;
    const phone = data.phone;
    const pass = data.pass;

    pool.query("INSERT INTO customer (Name, Email, Address, Phone, Password) VALUES (?, ?, ?, ?, ?)", [name, email, address, phone, pass], (err, result) => {

        if(err){
            return res.status(500).json({"error":err.message});
        }

        return res.status(201).json({
            "success":true,
            "message":"customer successfully signed up"
        });


    });





}


const login=(req,res)=> {

    const data = req.body;
    const email = data.email;
    const pass = data.pass;

    pool.query("SELECT * FROM customer WHERE Email = ? AND Password = ?",[email,pass],(err,result)=>{
            if(err){
                return res.status(500).json({ error: err.message });
            }

            const numRows = result.length;

            if(numRows>0){
            return res.status(201).json(result);
        }

        return res.status(500).json({error:"Incorrect Credentials"});



    });





   
    





};

const fetchCustomerDetails = (req,res)=>{

    const email = req.params.email;

    pool.query("SELECT * FROM customer WHERE Email = ? ",[email],(err1,result1)=>{
        if(err1){
            return res.status(500).json({ "error": err1.message });
        }

        const numRows = result1.length;

        if(numRows>0){

            return res.status(200).json({
                'success':true,
                'message':'Details for the given customer',
                'data':result1
            })
        }

        

});



}

const updateCustomerDetails = async (req,res)=> {

    const data = req.body;
    const email = data.email;
    const name = data.name;
    const address = data.address;
    const phone = data.phone;
    const pass = data.pass;
    const newEmail = data.newEmail;



    try {
        if(name != null && name !=''){
            await new Promise((resolve,reject)=>{
                pool.query("UPDATE customer SET Name = ? WHERE Email = ?",[name,email],(err,result)=>{
                    if(err){
                        return reject(err);
                    }
                    resolve(result);     
                    })


            })
            
       }
   
       if(address != null && address != ''){
            await new Promise((resolve,reject)=>{
                
                pool.query("UPDATE customer SET Address = ? WHERE Email = ?",[address,email],(err,result)=>{
                        if(err){
                            return reject(err);
                        }

                        resolve(result);
                    })
            })
       }
   
       if(phone != null && phone != ''){
        await new Promise((resolve,reject)=>{
            
           pool.query("UPDATE customer SET Phone = ? WHERE Email = ?",[phone,email],(err,result)=>{
            if(err){
                return reject(err);
            }

            resolve(result);
        })
        })
       }
   
       if(pass != null && pass != ''){
            await new Promise((resolve,reject)=>{
                pool.query("UPDATE seller SET Password = ? WHERE Email = ?",[pass,email],(err,result)=>{
                    if(err){
                       return reject(err);     
                    }

                    resolve(result);
                })
           
            })    
    
    }



    
        
       if(newEmail != null && newEmail != ''){
         await new Promise((resolve,reject)=>{
            
           pool.query("UPDATE customer SET Email = ? WHERE Email = ?",[newEmail,email],(err,result)=>{
            if(err){
                return reject(err);
            }

            resolve(result);
        })
         })
       }
   
       
       
   
   
   
       res.status(201).json({"message":"success"});
   
   
    }catch(err){
        res.status(400).json({"err":err.message});
    }

    


}


module.exports = {signup,login,fetchCustomerDetails,updateCustomerDetails};