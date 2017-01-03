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
    var slect_index:Int = 0
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
        print( Products[index].name!)
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
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .default, title: "編輯", handler: {(action, indexPath) -> Void in
            self.slect_index = indexPath.row
            self.performSegue(withIdentifier: "edit_product", sender: self)
            
        })
        
        editAction.backgroundColor = UIColor.green
        return [editAction ]
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL)-> UIImage {
        
        guard let imageData = try? Data(contentsOf: location) else {
            return UIImage(named: "")!
        }
        let image = UIImage(data: imageData)
        return image!
    }
    
    @IBAction func action_add(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "add_product", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_detail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DetailProductViewController
                destinationController.item = Products[indexPath.row]
            }
        }
        if segue.identifier == "add_product" {
            let destinationController = segue.destination as! EditProductViewController
            destinationController.mode = "add"
        }
        if segue.identifier == "edit_product" {
            let destinationController = segue.destination as! EditProductViewController
            destinationController.mode = "edit"
            destinationController.subindex = self.slect_index
            destinationController.index = searProduct(uid: Products[self.slect_index].uid!)
        }
    }
    
}
