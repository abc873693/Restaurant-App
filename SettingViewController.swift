//
//  ViewControllerLonin.swift
//  Restaurant_app
//
//  Created by Ray on 2016/12/28.
//  Copyright © 2016年 kuas. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SettingViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func action_myOder(_ sender: UIButton) {
        if getStatusValue(){
            self.performSegue(withIdentifier: "my_order", sender: self)
        }
        else {
            let quetion = UIAlertController(title: "警告", message: "尚未有訂單", preferredStyle: .alert);
            //新增選項
            let OKaction = UIAlertAction(title: "好", style: .default , handler: nil);
            quetion.addAction(OKaction);
            //Show
            self.present(quetion, animated: true, completion: nil);
        }
        print("\(getStatusValue())")
    }
    
    @IBAction func backstage(_ sender: UIButton) {
        self.performSegue(withIdentifier: "into_back", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "my_order" {
            let destinationController = segue.destination as! MyOrderViewController
            let token = getSettingValue()
            destinationController.Order_token = Int(token)!
        }
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
