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
    var small:Bool = false
    var medium:Bool = false
    var large:Bool = false
    
    @IBOutlet weak var image_main: UIImageView!
    @IBOutlet weak var text_name: UILabel!
    @IBOutlet weak var segment_price: UISegmentedControl!
    @IBOutlet weak var btn_add: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func action_add(_ sender: UIButton) {
        switch segment_price.selectedSegmentIndex {
        case 0:
            if large{
                btn_add.setTitle("+", for: .normal)
                large = false
            }
            else{
                btn_add.setTitle("-", for: .normal)
                large = true
            }
            break
        case 1:
            if medium{
                btn_add.setTitle("+", for: .normal)
                medium = false
            }
            else{
                btn_add.setTitle("-", for: .normal)
                medium = true
            }
            break
        default:
            if small{
                btn_add.setTitle("+", for: .normal)
                small = false
            }
            else{
                btn_add.setTitle("-", for: .normal)
                small = true
            }
            break
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func action_seg(_ sender: UISegmentedControl) {
        switch segment_price.selectedSegmentIndex {
        case 0:
            if large{
                btn_add.setTitle("-", for: .normal)
            }
            else{
                btn_add.setTitle("+", for: .normal)
            }
            break
        case 1:
            if medium{
                btn_add.setTitle("-", for: .normal)
            }
            else{
                btn_add.setTitle("+", for: .normal)
            }
            break
        default:
            if small{
                btn_add.setTitle("-", for: .normal)
            }
            else{
                btn_add.setTitle("+", for: .normal)
            }
            break
        }
    }
    
    func showOKDialog(title:String,message:String,OKtitle:String){
        let quetion = UIAlertController(title: title, message: message, preferredStyle: .alert);
        //新增選項
        let OKaction = UIAlertAction(title: OKtitle, style: .default , handler:nil);
        //把選項加到UIAlertController
        quetion.addAction(OKaction);
        //Show
        //self.present(quetion, animated: true, completion: nil);
    }

    
}
