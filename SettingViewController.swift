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
    var username = "abc873693@rainvisitor.com"
    var password = "123456"
    var ref: FIRDatabaseReference!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: username, password: password) { (user, error) in
            if user?.email != nil {
                let quetion = UIAlertController(title: "firebase", message: "登入成功", preferredStyle: .alert);
                //新增選項
                let OKaction = UIAlertAction(title: "好", style: .default , handler:nil);
                //把選項加到UIAlertController
                quetion.addAction(OKaction);
                //Show
                self.present(quetion, animated: true, completion: nil);
                self.ref.child("users").child((user?.uid)!).setValue(["username": self.username])
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

    }
    
    @IBAction func backstage(_ sender: UIButton) {
        self.performSegue(withIdentifier: "into_back", sender: self)
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
