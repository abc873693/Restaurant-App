//
//  ComfirmTableViewController.swift
//  Restaurant_app
//
//  Created by Ray on 2017/1/1.
//  Copyright © 2017年 kuas. All rights reserved.
//

import UIKit
import CoreData
import FirebaseDatabase
import FirebaseAuth

class ComfirmTableViewController: UITableViewController {

    var sum:Int? = 0
    @IBOutlet weak var text_sum: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //showData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func getContext()->NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    /*func showData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
        do {
            let results = try getContext().fetch(request)
            for result in results {
                let cdObj = result as! NSManagedObject
                let uid = cdObj.value(forKey: "uid") as? String
                let amount = cdObj.value(forKey: "amount") as? Int
                let size = cdObj.value(forKey: "size") as? Int
                //print("Product Name: \(result.name!), Price: \(result.price!)")
                let index = searProduct(uid:uid!)
                
            }
        }catch{
            fatalError("Failed to fetch data: \(error)")
        }
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "order_cell", for: indexPath)as! OrderTableViewCell
        let uid = orders[indexPath.row].uid
        let index = searProduct(uid:uid!)
        cell.text_name.text = products[index].name
        var price:Int?
        switch orders[indexPath.row].size! {
        case 0:
            price = Int(products[index].price_large!)
            break
        case 1:
            price = Int(products[index].price_medium!)
            break
        default:
            price = Int(products[index].price_small!)
            break
        }
        let amount = orders[indexPath.row].amount! as Int
        cell.text_amount.text = String(orders[indexPath.row].amount!)
        cell.text_price.text = String(price!) + "元"
        cell.text_sum.text = String(orders[indexPath.row].amount! * price!) + "元"
        cell.price = price!
        // Configure the cell...
        sum = sum! + ( amount * price!)
        text_sum.text = "總計 = " + String(sum!) + "元"
        cell.viewController = self
        return cell
    }
    

    @IBAction func SendData(_ sender: Any) {
        if orders.count == 0{
            let quetion = UIAlertController(title: "警告", message: "尚未有任何菜單", preferredStyle: .alert);
            //新增選項
            let OKaction = UIAlertAction(title: "好", style: .default , handler:{(action: UIAlertAction!) in
                
            });
            //把選項加到UIAlertController
            quetion.addAction(OKaction);
            self.present(quetion, animated: true, completion: nil);
        }
        else if !getStatusValue() {
            let now = NSDate()
            let current_token = String(Int(now.timeIntervalSince1970 * 100000))
            Set_SettingPlist_Value(value: current_token)
            var ref: FIRDatabaseReference!
            ref = FIRDatabase.database().reference()
            for i in 0...(orders.count-1){
                let model = orders[i]
                let product = ref.child("orders").child(current_token).child("product").child(String(i))
                product.child("uid").setValue(model.uid)
                product.child("amount").setValue(model.amount)
                product.child("size").setValue(model.size)
                ref.child("orders").child(current_token).child("status").setValue(true)
            }
            let quetion = UIAlertController(title: "提示", message: "已經生成菜單\n訂單編號:\(current_token)", preferredStyle: .alert);
            //新增選項
            let OKaction = UIAlertAction(title: "好", style: .default , handler:{(action: UIAlertAction!) in
                
            });
            //把選項加到UIAlertController
            quetion.addAction(OKaction);
            self.present(quetion, animated: true, completion: nil);
        }
        else {
            let quetion = UIAlertController(title: "提示", message: "已經生成菜單", preferredStyle: .alert);
            //新增選項
            let OKaction = UIAlertAction(title: "好", style: .default , handler:{(action: UIAlertAction!) in
                
            });
            //把選項加到UIAlertController
            quetion.addAction(OKaction);
            self.present(quetion, animated: true, completion: nil);
        }
        
        print("get \(getSettingValue())")
        print("get \(getStatusValue())")
    }
    
    
    func saveData(uid:String,amount:Int,size:Int){
        let context = getContext()
        let cdEntity = NSEntityDescription.entity(forEntityName: "Order", in: context)
        let cdObj = NSManagedObject(entity:cdEntity!,insertInto:context)
        cdObj.setValue(uid, forKey: "uid")
        cdObj.setValue(amount, forKey: "amount")
        cdObj.setValue(size, forKey: "size")
        let interVal = TimeInterval(RTLD_NOW)
        let date = NSDate(timeIntervalSince1970: interVal)
        cdObj.setValue(date, forKey: "date")
        do{
            try context.save()
            print("save success!!")
        }catch{
            print("Error: \(error)")
        }
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deletAction = UITableViewRowAction(style: .default, title: "刪除", handler: {(action, indexPath) -> Void in
            let cell = tableView.cellForRow(at: indexPath)as! OrderTableViewCell
            orders.remove(at: indexPath.row)
            self.sum = self.sum! - (cell.amount * cell.price)
            self.text_sum.text = "總計 = " + String(self.sum!) + "元"
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        })
        deletAction.backgroundColor = UIColor.red
        return [deletAction ]
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
