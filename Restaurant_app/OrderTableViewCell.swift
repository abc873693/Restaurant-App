//
//  OrderTableViewCell.swift
//  Restaurant_app
//
//  Created by Ray on 2017/1/1.
//  Copyright © 2017年 kuas. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    var amount:Int = 1
    var price:Int = 0
    var sum:Int = 0
    var viewController : UIViewController? = nil
    @IBOutlet weak var text_name: UILabel!
    @IBOutlet weak var text_amount: UILabel!
    @IBOutlet weak var text_price: UILabel!
    @IBOutlet weak var text_sum: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        text_amount.text = String(amount)
        // Initialization code
    }

    @IBAction func action_add(_ sender: UIButton) {
        let view = viewController as! ComfirmTableViewController
        if amount < 100 {
            amount = amount + 1
            view.sum = view.sum! + price
        }
        text_amount.text = String(amount)
        text_sum.text = String(amount * price) + "元"
        view.text_sum.text = "總計 = " + String(view.sum!) + "元"
    }
    
    @IBAction func action_sub(_ sender: UIButton) {
        let view = viewController as! ComfirmTableViewController
        if amount > 1 {
            amount = amount - 1
            view.sum = view.sum! - price
        }
        text_amount.text = String(amount)
        text_sum.text = String(amount * price) + "元"
        view.text_sum.text = "總計 = " + String(view.sum!) + "元"
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
