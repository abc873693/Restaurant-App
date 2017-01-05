//
//  OrderShowTableViewController.swift
//  Restaurant_app
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 kuas. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class OrderShowTableViewController: UITableViewController {
    var Orders = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getOrders()
        self.navigationItem.title = "所有訂單"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func getOrders() -> Void {
        Orders.removeAll()
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("orders").observeSingleEvent(of: .value, with: { (snapshot) in
            print( "firebaseData :" + snapshot.key)
            //let value = snapshot.value as? NSDictionary
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    // Make our jokes array for the tableView.
                    if (snap.value as? Dictionary<String, AnyObject>) != nil {
                        let key = snap.key
                        self.Orders.append(Int(key)!)
                        print( "firebaseData :" + key)
                    }
                }
                self.Orders.reverse()
                self.tableView.reloadData()
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

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
        return Orders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "order_cell", for: indexPath)as! OrderDetailTableViewCell
        cell.order_token?.text = "編號：\(Orders[indexPath.row])"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_order_detail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! OrderDetailViewController
                destinationController.Order_token = Orders[indexPath.row]
            }
        }
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
