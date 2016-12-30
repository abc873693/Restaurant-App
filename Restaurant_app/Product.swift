//
//  Product.swift
//  Restaurant_app
//
//  Created by Ray on 2016/12/29.
//  Copyright © 2016年 kuas. All rights reserved.
//

var types = [String]()
var products = [Product]()


class Product {
    var uid:Int?
    var name:String?
    var type:String?
    var image_url:String?
    var price_large:Int?
    var price_medium:Int?
    var price_small:Int?
    var status:Bool?
    var single:Bool?
    
    init(name:String, type:String, image_URL:String, price_large:Int,price_small:Int, status:Bool) {
        self.name = name
        self.type = type
        self.image_url = image_URL
        self.price_large = price_large
        self.price_small = price_small
        self.single = false
        self.status = status
    }
    
    init(name:String, type:String, image_URL:String, price_large:Int, status:Bool) {
        self.name = name
        self.type = type
        self.image_url = image_URL
        self.price_large = price_large
        self.price_small = nil
        self.single = true
        self.status = status
    }
    init() {
        
    }
}
