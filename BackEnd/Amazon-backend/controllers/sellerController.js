const mysql = require('mysql2');
const pool = mysql.createPool({
    host : 'localhost',
    user : 'root',
    password : '',
    database : 'amazon_clone'
})

//@desc POST seller
//@route POST /seller/signup
//@access public

const signup = (req, res) => {
    const data = req.body;
    const name = data.name;
    const email = data.email;
    const bank = data.bankAccount;
    const phone = data.phone;
    const pass = data.pass;
    const storeName = data.storeName;

    pool.query("INSERT INTO seller (Name, Email, BankAccount, Phone, Password) VALUES (?, ?, ?, ?, ?)", [name, email, bank, phone, pass], (err, result) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }

        pool.query("SELECT SellerID FROM seller WHERE Email = ?", [email], (err, result) => {
            if (err) {
                return res.status(500).json({ error: err.message });
            }

            const SellerID = result[0].SellerID;

            pool.query("INSERT INTO store (StoreName, SellerID) VALUES (?, ?)", [storeName, SellerID], (err, result) => {
                if (err) {
                    return res.status(500).json({ error: err.message });
                }

                res.status(201).json({
                    "success":true,
                    "message":"Seller successfully signed up",
                    "data":result,
        
                });
            
            });
        });

        
    });
}

//@desc POST LOGINSELLER
//@route POST /seller/login
//@access public

const login=(req,res)=> {

    const data = req.body;
    const email = data.email;
    const pass = data.pass;

    pool.query("SELECT * FROM seller WHERE Email = ? AND Password = ?",[email,pass],(err,result)=>{
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


//@desc GET sellerDetails
//@route POST /seller/signup
//@access public
const fetchSellerDetails=(req,res)=> {

    const email = req.params.email;
    //const email = data.email;
   // console.log(email);

    // if(email!=null && email!=''){
    //     console.log("Email is not null");
    // }

    pool.query("SELECT * FROM seller WHERE Email = ? ",[email],(err1,result1)=>{
            if(err1){
                return res.status(500).json({ "error": err1.message });
            }

            const numRows = result1.length;

            if(numRows>0){

            const seller = result1[0];
            const sellerID = seller.SellerID;
            
            pool.query("SELECT * FROM store WHERE SellerID = ? ",[sellerID],(err2,result2)=>{
                if(err2){
                    return res.status(500).json({"error":err2.message});
                }

                
                if(result2.length>0){
                    const store = result2[0];
                    const combinedResult = {
                        ...seller,
                        ...store
                    }    
                    return res.status(200).json({
                        "success":true,
                        "message":"Seller details",
                        "data":combinedResult
                    })    
                }    


            })
                
                
            } else {

        return res.status(500).json({error:"Incorrect Credentials"});
    }


    });
};

// const updateSellerDetails = (req, res) => {
//     const data = req.body;
//     const { email, name, bankAccount, phone, pass, newEmail } = data;

//     let updateFields = [];

//     if (name && name !== '') {
//         updateFields.push({ field: 'Name', value: name });
//     }

//     if (bankAccount && bankAccount !== '') {
//         updateFields.push({ field: 'BankAccount', value: bankAccount });
//     }

//     if (phone && phone !== '') {
//         updateFields.push({ field: 'Phone', value: phone });
//     }

//     if (pass && pass !== '') {
//         updateFields.push({ field: 'Password', value: pass });
//     }

//     const updateField = (field, value, email, callback) => {
//         pool.query(`UPDATE seller SET ${field} = ? WHERE Email = ?`, [value, email], (err, result) => {
//             if (err) {
//                 callback(err);
//             } else {
//                 callback(null);
//             }
//         });
//     };

//     const updateAllFields = (index, callback) => {
//         if (index < updateFields.length) {
//             const { field, value } = updateFields[index];
//             updateField(field, value, email, (err) => {
//                 if (err) {
//                     callback(err);
//                 } else {
//                     updateAllFields(index + 1, callback);
//                 }
//             });
//         } else {
//             callback(null);
//         }
//     };

//     updateAllFields(0, (err) => {
//         if (err) {
//             return res.status(500).json({ error: err.message });
//         }

//         if (newEmail && newEmail !== '') {
//             pool.query("UPDATE seller SET Email = ? WHERE Email = ?", [newEmail, email], (err, result) => {
//                 if (err) {
//                     return res.status(500).json({ error: err.message });
//                 }
//                 return res.status(200).json({ message: "Update successful" });
//             });
//         } else {
//             return res.status(200).json({ message: "Update successful" });
//         }
//     });
// };



const updateSellerDetails = async (req,res)=> {

    const data = req.body;
    const email = data.email;
    const name = data.name;
    const bank = data.bankAccount;
    const phone = data.phone;
    const pass = data.pass;
    const newEmail = data.newEmail;
    const store = data.storeName;


    try {
        if(name != null && name !=''){
            await new Promise((resolve,reject)=>{
                pool.query("UPDATE seller SET Name = ? WHERE Email = ?",[name,email],(err,result)=>{
                    if(err){
                        return reject(err);
                    }
                    resolve(result);     
                    })


            })
            
       }
   
       if(bank != null && bank != ''){
            await new Promise((resolve,reject)=>{
                
                pool.query("UPDATE seller SET BankAccount = ? WHERE Email = ?",[bank,email],(err,result)=>{
                        if(err){
                            return reject(err);
                        }

                        resolve(result);
                    })
            })
       }
   
       if(phone != null && phone != ''){
        await new Promise((resolve,reject)=>{
            
           pool.query("UPDATE seller SET Phone = ? WHERE Email = ?",[phone,email],(err,result)=>{
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



    
    await new Promise((resolve,reject)=>{

        pool.query("SELECT SellerID FROM seller WHERE Email = ?", [email], async (err, result) => {
            if (err) {
                return reject(err);
            }

            
            const seller = result[0];
            const sellerID = seller.SellerID;

            if(store != null && store != ''){
                await new Promise((resolve,reject)=>{
                    pool.query("UPDATE store SET StoreName = ? where SellerID = ? ",[store,sellerID],(err,result)=>{
                        if(err){
                            return reject(err);
                        }
    
                        resolve(result);
                    })
                })
            }
        
            resolve(result);
        })
    

    })
    


        
       if(newEmail != null && newEmail != ''){
         await new Promise((resolve,reject)=>{
            
           pool.query("UPDATE seller SET Email = ? WHERE Email = ?",[newEmail,email],(err,result)=>{
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




module.exports = {signup,login,fetchSellerDetails,updateSellerDetails};

