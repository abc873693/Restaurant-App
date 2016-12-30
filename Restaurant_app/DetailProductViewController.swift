//
//  DetailProductViewController.swift
//  Restaurant_app
//
//  Created by Ray on 2016/12/30.
//  Copyright © 2016年 kuas. All rights reserved.
//

import UIKit

class DetailProductViewController: UIViewController,URLSessionDelegate {

    var item:Product!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var product_image: UIImageView!
    @IBOutlet weak var price_large: UILabel!
    @IBOutlet weak var price_medium: UILabel!
    @IBOutlet weak var price_small: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = item.name
        price_large.text = String(item.price_large!)
        price_medium.text = String(item.price_medium!)
        price_small.text = String(item.price_small!)
        if self.item.image_url != "null" {
            let url = self.item.image_url
            
            let sessionWithConfigure = URLSessionConfiguration.default
            
            let session = Foundation.URLSession(configuration: sessionWithConfigure, delegate: self, delegateQueue: OperationQueue.main)
            
            //let dataTask = session.downloadTask(with: URL(string: url!)!)
            
            let dataTask = session.downloadTask(with: URL(string: url!)!, completionHandler: {(data, response, error) -> Void in
                guard let imageData = try? Data(contentsOf: data!) else {
                    return
                }
                let image = UIImage(data: imageData)
                if image != nil{
                    self.product_image.image = image
                    
                }
            })
            
            dataTask.resume()
            
        }
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

}
