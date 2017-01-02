//
//  BackStageMainViewController.swift
//  Restaurant_app
//
//  Created by Ray on 2017/1/2.
//  Copyright © 2017年 kuas. All rights reserved.
//

import UIKit

class BackStageMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "後台管理"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func action_product(_ sender: UIButton) {
        self.performSegue(withIdentifier: "into_menu", sender: self)
    }

    @IBAction func action_orders(_ sender: UIButton) {
        self.performSegue(withIdentifier: "into_order", sender: self)
    }

}
