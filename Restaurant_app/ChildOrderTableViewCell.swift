//
//  ChildOrderTableViewCell.swift
//  Restaurant_app
//
//  Created by Ray on 2017/1/1.
//  Copyright © 2017年 kuas. All rights reserved.
//

import UIKit

class ChildOrderTableViewCell: UITableViewCell {
    var uid:String = "" 
    @IBOutlet weak var image_main: UIImageView!
    @IBOutlet weak var text_name: UILabel!
    @IBOutlet weak var segment_price: UISegmentedControl!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var step_amount: UIStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        amount.text = "0"
        // Initialization code
    }
    @IBAction func action_step(_ sender: UIStepper) {
        amount.text = "\(Int(step_amount.value))"
    }

    @IBAction func action_add(_ sender: UIButton) {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
