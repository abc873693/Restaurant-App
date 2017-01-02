//
//  Product.swift
//  Restaurant_app
//
//  Created by Ray on 2016/12/29.
//  Copyright © 2016年 kuas. All rights reserved.
//
import Foundation
import CoreData

var types = [String]()
var products = [Product]()
var orders = [SlectProduct]()

public func searProduct(uid:String)-> Int{
    for i in 0...(products.count-1) {
        if products[i].uid == uid{
            return i
        }
    }
    return -1
}

class Product {
    var uid:String?
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
class Post {
    var id:String?
    var title:String?
    var date:String?
    var content:String?
    var likes:String?
    var shares:String?
    var image_picture_URL:String?
    var image_page_URL:String?
    var link_URL:String?
    var video_link_URL:String?
    var type:String?
    var image_json:String?
    init() {
        
    }
}

class SlectProduct {
    var uid:String?
    var amount:Int?
    var size:Int?
    var index:Int?
    init() {
        
    }
}
