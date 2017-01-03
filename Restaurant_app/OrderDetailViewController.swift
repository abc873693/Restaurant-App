//
//  OrderDetailViewController.swift
//  Restaurant_app
//
//  Created by Ray on 2017/1/4.
//  Copyright © 2017年 kuas. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class OrderDetailViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var orderForProduct = [SlectProduct]()
    var Order_token:Int = 0
    @IBOutlet weak var take_token: UILabel!
    @IBOutlet weak var tableview_prodcut: UITableView!
    @IBOutlet weak var switch_state: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        take_token.text = "編號：\(Order_token)"
        tableview_prodcut.delegate = self
        tableview_prodcut.dataSource = self
        getProdctData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getProdctData(){
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("orders").observeSingleEvent(of: .value, with: { (snapshot) in
            print( "firebaseData :" + snapshot.key)
            //let value = snapshot.value as? NSDictionary
            if let order = snapshot.childSnapshot(forPath: "\(self.Order_token)").value as? NSDictionary {
                self.switch_state.isOn = order["status"] as? Bool ?? false
                let item = order["product"] as! [NSDictionary]
                //print("\(order["product"]!)")
                for DS in item {
                    let model = SlectProduct()
                    model.uid = DS["uid"] as? String
                    model.amount = DS["amount"] as? Int
                    model.size = DS["size"] as? Int
                    model.state = DS["state"] as? Bool ?? false
                    self.orderForProduct.append(model)
                    print( "model.uid : \(model.uid!)")
                }
                self.tableview_prodcut.reloadData()
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orderForProduct.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product_cell", for: indexPath) as! OrderProductTableViewCell
        let index = indexPath.row
        let uid = orderForProduct[index].uid
        let index_Product = searProduct(uid: uid!)
        cell.text_name.text = "\(products[index_Product].name!)"
        cell.text_amount.text = "\(orderForProduct[index].amount!)份"
        switch orderForProduct[index].size! {
        case 0:
            cell.text_size.text = "大"
            break
        case 1:
            cell.text_size.text = "中"
            break
        default:
            cell.text_size.text = "小"
            break
        }
        cell.product_state.isOn = orderForProduct[index].state!
        return cell
    }
}
