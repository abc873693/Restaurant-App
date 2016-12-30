//
//  ViewControllerAll.swift
//  Restaurant_app
//
//  Created by Ray on 2016/12/28.
//  Copyright © 2016年 kuas. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewControllerAll: UITableViewController {
    //var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTypeData()
        getProductData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func showOKDialog(title:String,message:String,OKtitle:String){
        let quetion = UIAlertController(title: title, message: message, preferredStyle: .alert);
        //新增選項
        let OKaction = UIAlertAction(title: OKtitle, style: .default , handler:nil);
        //把選項加到UIAlertController
        quetion.addAction(OKaction);
        //Show
        self.present(quetion, animated: true, completion: nil);
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
                self.tableView.reloadData()
                
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
                    // Make our jokes array for the tableView.
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let model = Product()
                        let value = postDictionary as? NSDictionary
                        let price = postDictionary["price"] as? NSDictionary
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
                self.tableView.reloadData()
                
            }
            
            //self.showOKDialog(title:"data",message:username,OKtitle:"OK")
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "type_cell", for: indexPath)as! TypeTableViewCell
        cell.text_title?.text = types[indexPath.row]
        
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_type_products" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! ProductTableViewController
                destinationController.type = types[indexPath.row]
            }
        }
        
    }

    
}
