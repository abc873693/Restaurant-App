//
//  LoginViewController.swift
//  Restaurant_app
//
//  Created by Ray on 2017/1/2.
//  Copyright © 2017年 kuas. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {
    var ref: FIRDatabaseReference!
    
    @IBOutlet weak var edit_username: UITextField!
    @IBOutlet weak var edit_password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "後台登入"
        ref = FIRDatabase.database().reference()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Action_Login(_ sender: Any) {
        let username = edit_username.text
        let password = edit_password.text
        login(username:username!,password:password!)
    }
    
    
    
    func login(username:String,password:String) -> Void {
        FIRAuth.auth()?.signIn(withEmail: username, password: password) { (user, error) in
            if user?.email != nil {
                self.performSegue(withIdentifier: "login", sender: self)
            }
            else {
                let quetion = UIAlertController(title: "訊息", message: "登入失敗", preferredStyle: .alert);
                //新增選項
                let OKaction = UIAlertAction(title: "好", style: .default , handler:nil);
                //把選項加到UIAlertController
                quetion.addAction(OKaction);
                //Show
                self.present(quetion, animated: true, completion: nil);
            }
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
