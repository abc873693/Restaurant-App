//
//  ProductTableViewController.swift
//  Restaurant_app
//
//  Created by Ray on 2016/12/29.
//  Copyright © 2016年 kuas. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class ProductTableViewController: UITableViewController, URLSessionDelegate {
    
    var type = ""
    var Products = [(Product)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type)
        self.navigationItem.title = type
        for model in products {
            let mtype = model.type
            //let str = (mtype! + mtype!.isEqual(type))as! String
            if mtype!.isEqual(type) {
                Products.append(model)
            }
        }
        self.tableView.reloadData()
        print(Products.count)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return Products.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product_cell", for: indexPath)as! ProductTableViewCell
        let index = indexPath.row
        cell.text_name.text = Products[index].name
        print( Products[index].name! + "  " + String(Products[index].single!))
        let large = (Products[index].price_large! != 0) ? "大:" + String(Products[index].price_large!) : ""
        let medium = (Products[index].price_medium! != 0) ? "中:" + String(Products[index].price_medium!) : ""
        let small = (Products[index].price_small! != 0) ? "小:" + String(Products[index].price_small!) : ""
        cell.text_price.text = large + " " + medium + " " +  small
        if Products[index].image_url != "null" {
            let url = Products[index].image_url
            cell.indicator_image.startAnimating()
            let sessionWithConfigure = URLSessionConfiguration.default
            
            let session = Foundation.URLSession(configuration: sessionWithConfigure, delegate: self, delegateQueue: OperationQueue.main)
            
            //let dataTask = session.downloadTask(with: URL(string: url!)!)
            
            let dataTask = session.downloadTask(with: URL(string: url!)!, completionHandler: {(data, response, error) -> Void in
                guard let imageData = try? Data(contentsOf: data!) else {
                    cell.indicator_image.stopAnimating()
                    return
                }
                let image = UIImage(data: imageData)
                if image != nil{
                    cell.image_main.image = image
                    
                }
                cell.indicator_image.stopAnimating()
            })
            
            dataTask.resume()
            
        }else{
            cell.indicator_image.stopAnimating()
        }
        
        // Configure the cell...
        
        return cell
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL)-> UIImage {
        
        guard let imageData = try? Data(contentsOf: location) else {
            return UIImage(named: "")!
        }
        let image = UIImage(data: imageData)
        return image!
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_detail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DetailProductViewController
                destinationController.item = Products[indexPath.row]
            }
        }
    }
    
}
