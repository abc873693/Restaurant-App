//
//  EditProductViewController.swift
//  Restaurant_app
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 kuas. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class EditProductViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    var mode:String = ""
    var subindex:Int = 0
    var index:Int = 0
    //var model = Product()
    @IBOutlet weak var edit_uid: UITextField!
    @IBOutlet weak var edit_name: UITextField!
    @IBOutlet weak var edit_price_large: UITextField!
    @IBOutlet weak var edit_price_medium: UITextField!
    @IBOutlet weak var edit_price_small: UITextField!
    @IBOutlet weak var switch_state: UISwitch!
    @IBOutlet weak var switch_large: UISwitch!
    @IBOutlet weak var switch_medium: UISwitch!
    @IBOutlet weak var switch_small: UISwitch!
    @IBOutlet weak var picker_type: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker_type.delegate = self
        picker_type.dataSource = self
        if mode == "add" {
            self.navigationItem.title = "新增產品"
            index = products.count
            edit_uid.text = String(index)
        }
        else if mode == "edit" {
            self.navigationItem.title = "編輯產品"
            edit_uid.text = String(index)
            edit_name.text = products[index].name
            edit_price_large.text = String(products[index].price_large!)
            edit_price_medium.text = String(products[index].price_medium!)
            edit_price_small.text = String(products[index].price_small!)
            if edit_price_large.text == "0" {
                edit_price_large.isEnabled = false
                switch_large.isOn = false

            }
            if edit_price_medium.text == "0" {
                edit_price_medium.isEnabled = false
                switch_medium.isOn = false
            }
            if edit_price_small.text == "0" {
                edit_price_small.isEnabled = false
                switch_small.isOn = false
            }
            switch_state.isOn = products[index].status!
            let type_index = searType(name:products[index].type!)
            picker_type.selectRow(type_index, inComponent: 0, animated: false)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func action_large(_ sender: UISwitch) {
        if !sender.isOn {
            edit_price_large.isEnabled = false
            edit_price_large.text = "0"
        }
        else {
            edit_price_large.isEnabled = true
        }
    }

    @IBAction func action_medium(_ sender: UISwitch) {
        if !sender.isOn {
            edit_price_medium.isEnabled = false
            edit_price_medium.text = "0"
        }
        else {
            edit_price_medium.isEnabled = true
        }
    }
    
    @IBAction func action_small(_ sender: UISwitch) {
        if !sender.isOn {
            edit_price_small.isEnabled = false
            edit_price_small.text = "0"
        }
        else {
            edit_price_small.isEnabled = true
        }
    }
    
    @IBAction func action_finish(_ sender: UIButton) {
        let flag = edit_name.text != "" && edit_price_large.text != "" && edit_price_medium.text != "" && edit_price_small.text != ""
        if flag {
            if mode == "add" {
                var message:String = ""
                message = message + "編號:\(index)\n"
                message = message + "名稱:\(edit_name.text!)\n"
                message = message + "大份價格:\(edit_price_large.text!)\n"
                message = message + "中份價格:\(edit_price_medium.text!)\n"
                message = message + "小份價格:\(edit_price_small.text!)\n"
                let str = (switch_state.isOn) ? "是" : "否"
                message = message + "上架狀態:\(str)\n"
                let index_tmp = picker_type.selectedRow(inComponent: 0)
                message = message + "類型:\(types[index_tmp])\n"
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
                message = message + "大份價格:\(edit_price_large.text!)\n"
                message = message + "中份價格:\(edit_price_medium.text!)\n"
                message = message + "小份價格:\(edit_price_small.text!)\n"
                let str = (switch_state.isOn) ? "是" : "否"
                message = message + "上架狀態:\(str)\n"
                let index_tmp = picker_type.selectedRow(inComponent: 0)
                message = message + "類型:\(types[index_tmp])\n"
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
        let model = Product()
        model.uid = edit_uid.text!
        model.name = edit_name.text!
        model.price_large = Int(edit_price_large.text!)
        model.price_medium = Int(edit_price_medium.text!)
        model.price_small = Int(edit_price_small.text!)
        model.status = switch_state.isOn
        model.image_url = "null"
        let index_tmp = picker_type.selectedRow(inComponent: 0)
        model.type = types[index_tmp]
        let post = ["uid": model.uid!,
                    "name": model.name!,
                    "price": ["large":model.price_large,"medium":model.price_medium,"small":model.price_small],
                    "status": model.status!,
                    "type": model.type!,
                    "image_url":model.image_url!] as [String : Any]
        let childUpdates = ["/menus/\(index)": post]
        ref.updateChildValues(childUpdates)
        products.append(model)
        back()
        
    }
    
    func updateType() -> Void {
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        
        products[index].name = edit_name.text!
        products[index].price_large = Int(edit_price_large.text!)
        products[index].price_medium = Int(edit_price_medium.text!)
        products[index].price_small = Int(edit_price_small.text!)
        products[index].status = switch_state.isOn
        let index_tmp = picker_type.selectedRow(inComponent: 0)
        products[index].type = types[index_tmp]
        let post = ["uid": index,
                    "name": products[index].name!,
                    "price": ["large":products[index].price_large,"medium":products[index].price_medium,"small":products[index].price_small],
                    "status": products[index].status!,
                    "type": products[index].type!,
                    "image_url":products[index].image_url!] as [String : Any]
        let childUpdates = ["/menus/\(index)": post]
        ref.updateChildValues(childUpdates)
        back()
    }
    
    func back()-> Void {
        let i = (navigationController?.viewControllers.count)! - 2
        let View = navigationController?.viewControllers[i] as! ProductTableViewController
        View.tableView.reloadData()
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int)->Int {
        return types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
}
