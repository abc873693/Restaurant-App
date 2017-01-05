//
//  OrderProductTableViewCell.swift
//  Restaurant_app
//
//  Created by Ray on 2017/1/4.
//  Copyright © 2017年 kuas. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class OrderProductTableViewCell: UITableViewCell {

    var view:OrderDetailViewController?
    var index:Int? = 0
    @IBOutlet weak var text_name: UILabel!
    @IBOutlet weak var text_amount: UILabel!
    @IBOutlet weak var text_size: UILabel!
    @IBOutlet weak var product_state: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func action_enable_product(_ sender: UISwitch) {
        let token = view?.Order_token
        view?.orderForProduct[index!].state = sender.isOn
        let model = (view?.orderForProduct[index!])! as SlectProduct
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        let post = ["amount": model.amount!,
                    "size": model.size!,
                    "uid": model.uid!,
                    "state": model.state!] as [String : Any]
        let childUpdates = ["/orders/\(token!)/product/\(index!)": post]
        ref.updateChildValues(childUpdates)
    }
    

}
