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
        self.tableView.reloadData()
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
