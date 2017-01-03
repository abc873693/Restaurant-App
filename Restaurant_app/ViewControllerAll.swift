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
    var slect_index:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showOKDialog(title:String,message:String,OKtitle:String){
        let quetion = UIAlertController(title: title, message: message, preferredStyle: .alert);
        //新增選項
        let OKaction = UIAlertAction(title: OKtitle, style: .default , handler:nil);
        //把選項加到UIAlertController
        quetion.addAction(OKaction);
        //Show
        self.present(quetion, animated: true, completion: nil);
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "type_cell", for: indexPath)as! TypeTableViewCell
        cell.text_title?.text = types[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .default, title: "編輯", handler: {(action, indexPath) -> Void in
            self.slect_index = indexPath.row
            self.performSegue(withIdentifier: "edit_type", sender: self)
            
        })
        
        editAction.backgroundColor = UIColor.green
        return [editAction ]

    }
    
    @IBAction func action_add(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "add_type", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_type_products" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! ProductTableViewController
                destinationController.type = types[indexPath.row]
            }
        }
        if segue.identifier == "add_type" {
            let destinationController = segue.destination as! EditTypeViewController
            destinationController.mode = "add"
        }
        if segue.identifier == "edit_type" {
            let destinationController = segue.destination as! EditTypeViewController
            destinationController.mode = "edit"
            destinationController.index = self.slect_index
        }
        
    }

    
}
