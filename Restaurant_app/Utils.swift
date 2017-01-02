//
//  Utils.swift
//  Restaurant_app
//
//  Created by Ray on 2016/12/29.
//  Copyright © 2016年 kuas. All rights reserved.
//

import Foundation
import FirebaseDatabase
import UIKit

class Util{
    
}
public func getSettingValue() -> String{
    var value:String! = "";
    let path = Bundle.main.path(forResource: "MyList", ofType: "plist")
    let dict = NSMutableDictionary(contentsOfFile: path!)
    //欄位名稱
    if (dict?.object(forKey: "current_token") != nil){
        value = dict!.object(forKey: "current_token") as! String;
    }
    return value;
}

public func getStatusValue() -> Bool{
    var value:Bool! = false;
    let path = Bundle.main.path(forResource: "MyList", ofType: "plist")
    let dict = NSMutableDictionary(contentsOfFile: path!)
    //欄位名稱
    if (dict?.object(forKey: "order_status") != nil){
        value = dict!.object(forKey: "order_status") as! Bool;
    }
    return value;
}

public func Set_SettingPlist_Value(value:String){
    print("set \(value)")
    let path = Bundle.main.path(forResource: "MyList", ofType: "plist")
    let dict = NSMutableDictionary(contentsOfFile: path!)
    dict?.setObject(value, forKey: "current_token" as NSCopying)
    dict?.setObject(true, forKey: "order_status" as NSCopying)
    dict?.write(toFile: path!, atomically: true)
}
