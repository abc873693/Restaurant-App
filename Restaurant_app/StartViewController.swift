//
//  ViewController.swift
//  Restaurant_app
//
//  Created by Ray on 2016/12/28.
//  Copyright © 2016年 kuas. All rights reserved.
//

import UIKit
import FirebaseAuth

class StartViewController: UIViewController {
    var username = "abc873693@rainvisitor.com"
    var password = "123456"
    override func viewDidLoad() {
        super.viewDidLoad()
        FIRAuth.auth()?.signIn(withEmail: username, password: password) { (user, error) in
            if user?.email != nil {
                /*let quetion = UIAlertController(title: "firebase", message: "登入成功", preferredStyle: .alert);
                //新增選項
                let OKaction = UIAlertAction(title: "好", style: .default , handler:{(action: UIAlertAction!) in
                    self.performSegue(withIdentifier: "into_menu", sender: self)
                });
                //把選項加到UIAlertController
                quetion.addAction(OKaction);
                //Show
                self.present(quetion, animated: true, completion: nil);*/
                self.performSegue(withIdentifier: "into_menu", sender: self)
            }
            else {
                let quetion = UIAlertController(title: "firebase", message: "創建失敗", preferredStyle: .alert);
                //新增選項
                let OKaction = UIAlertAction(title: "好", style: .default , handler:nil);
                //把選項加到UIAlertController
                quetion.addAction(OKaction);
                //Show
                self.present(quetion, animated: true, completion: nil);
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

