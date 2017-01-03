//
//  ViewController.swift
//  Restaurant_app
//
//  Created by Ray on 2016/12/28.
//  Copyright © 2016年 kuas. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class StartViewController: UIViewController {
    var username = "abc873693@rainvisitor.com"
    var password = "123456"
    override func viewDidLoad() {
        super.viewDidLoad()
        FIRAuth.auth()?.signIn(withEmail: username, password: password) { (user, error) in
            if user?.email != nil {
                /*let quetion = UIAlertController(title: "firebase", message: "登入成功", preferredStyle: .alert);
                //新增選項
                let OKaction = UIAlertAction(title: "好", style: .default , handler:{(action: UIAlertAction!) in
                    self.performSegue(withIdentifier: "into_menu", sender: self)
                });
                //把選項加到UIAlertController
                quetion.addAction(OKaction);
                //Show
                self.present(quetion, animated: true, completion: nil);*/
                self.getTypeData()
                self.getProductData()
            }
            else {
                let quetion = UIAlertController(title: "firebase", message: "創建失敗", preferredStyle: .alert);
                //新增選項
                let OKaction = UIAlertAction(title: "好", style: .default , handler:nil);
                //把選項加到UIAlertController
                quetion.addAction(OKaction);
                //Show
                self.present(quetion, animated: true, completion: nil);
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTypeData(){
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        /*let userID = FIRAuth.auth()?.currentUser?.uid*/
        ref.child("type").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var str = ""
            print( "firebaseData :" + snapshot.key)
            //let value = snapshot.value as? NSDictionary
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshots {
                    
                    // Make our jokes array for the tableView.
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        //let joke = Joke(key: key, dictionary: postDictionary)
                        let value = postDictionary as? NSDictionary
                        let chtname = value?["chtName"] as? String ?? ""
                        // Items are returned chronologically, but it's more fun with the newest jokes first.
                        str = chtname
                        types.append(str)
                        print( "firebaseData :" + key + ":" + chtname)
                        //self.jokes.insert(joke, atIndex: 0)
                    }
                }
                
            }
            
            //self.showOKDialog(title:"data",message:username,OKtitle:"OK")
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func getProductData(){
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        /*let userID = FIRAuth.auth()?.currentUser?.uid*/
        ref.child("menus").observeSingleEvent(of: .value, with: { (snapshot) in
            
            print( "firebaseData :" + snapshot.key)
            //let value = snapshot.value as? NSDictionary
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshots {
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let model = Product()
                        let value = postDictionary as? NSDictionary
                        let price = postDictionary["price"] as? NSDictionary
                        model.uid = snap.key
                        model.name = value?["name"] as? String ?? "null"
                        model.status = value?["status"] as? Bool ?? false
                        model.image_url = value?["image_url"] as? String ?? "null"
                        model.type = value?["type"] as? String ?? "null"
                        model.price_large = price?["large"] as? Int ?? 0
                        model.price_small = price?["small"] as? Int ?? 0
                        model.price_medium = price?["medium"] as? Int ?? 0
                        model.single = price?["single"] as? Bool ?? false
                        
                        products.append(model)
                        print( "firebaseData :" + key + ":" + model.name!)
                        //self.jokes.insert(joke, atIndex: 0)
                    }
                }
                self.performSegue(withIdentifier: "into_menu", sender: self)
            }
            
            //self.showOKDialog(title:"data",message:username,OKtitle:"OK")
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}

