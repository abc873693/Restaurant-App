//
//  OrderProductTableViewCell.swift
//  Restaurant_app
//
//  Created by Ray on 2017/1/4.
//  Copyright © 2017年 kuas. All rights reserved.
//

import UIKit

class OrderProductTableViewCell: UITableViewCell {

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

}
