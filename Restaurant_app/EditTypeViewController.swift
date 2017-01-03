//
//  EditTypeViewController.swift
//  Restaurant_app
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 kuas. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class EditTypeViewController: UIViewController {

    var mode:String = ""
    var index:Int = 0
    @IBOutlet weak var edit_uid: UITextField!
    @IBOutlet weak var edit_name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if mode == "add" {
            self.navigationItem.title = "新增類型"
            index = types.count
            edit_uid.text = String(index)
        }
        else if mode == "edit" {
            self.navigationItem.title = "編輯類型"
            edit_uid.text = String(index)
            edit_name.text = types[index]
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func action_finished(_ sender: UIButton) {
        if edit_name.text != "" {
            if mode == "add" {
                var message:String = ""
                message = message + "編號:\(index)\n"
                message = message + "名稱:\(edit_name.text!)\n"
                message = message + "確定新增？"
                let quetion = UIAlertController(title: "訊息", message: message, preferredStyle: .alert);
                //新增選項
                let OKaction = UIAlertAction(title: "好", style: .default , handler: { (action: UIAlertAction!) in
                    self.addType()
                });
                let Cancelaction = UIAlertAction(title: "取消", style: .default , handler:nil);
                //把選項加到UIAlertController
                quetion.addAction(Cancelaction);
                quetion.addAction(OKaction);
                //Show
                self.present(quetion, animated: true, completion: nil);
            }
            else if mode == "edit" {
                var message:String = ""
                message = message + "編號:\(index)\n"
                message = message + "名稱:\(edit_name.text!)\n"
                message = message + "確定更改？"
                let quetion = UIAlertController(title: "訊息", message: message, preferredStyle: .alert);
                //新增選項
                let OKaction = UIAlertAction(title: "好", style: .default , handler: { (action: UIAlertAction!) in
                    self.updateType()
                });
                let Cancelaction = UIAlertAction(title: "取消", style: .default , handler:nil);
                //把選項加到UIAlertController
                quetion.addAction(Cancelaction);
                quetion.addAction(OKaction);
                //Show
                self.present(quetion, animated: true, completion: nil);
                
            }
        }
        else {
            let quetion = UIAlertController(title: "警告", message: "請勿留空", preferredStyle: .alert);
            //新增選項
            let OKaction = UIAlertAction(title: "好", style: .default , handler: nil);
            quetion.addAction(OKaction);
            //Show
            self.present(quetion, animated: true, completion: nil);
        }
        
    }

    func addType() -> Void {
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("type").child(String(index)).setValue(["uid": index,
                                                    "chtName": edit_name.text!])
        types.append(edit_name.text!)
        back()
        
    }
    
    func updateType() -> Void {
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        let post = ["uid": index,
                    "chtName": edit_name.text!] as [String : Any]
        types[index] = edit_name.text!
        let childUpdates = ["/type/\(index)": post]
        ref.updateChildValues(childUpdates)
        back()
    }

    func back()-> Void {
        let i = (navigationController?.viewControllers.count)! - 2
        let View = navigationController?.viewControllers[i] as! ViewControllerAll
        View.tableView.reloadData()
        _ = navigationController?.popViewController(animated: true)
    }

}
