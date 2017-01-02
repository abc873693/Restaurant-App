//
//  Order+CoreDataProperties.swift
//  Restaurant_app
//
//  Created by Ray on 2017/1/1.
//  Copyright © 2017年 kuas. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order");
    }

    @NSManaged public var amount: Int16
    @NSManaged public var size: Int16
    @NSManaged public var uid: String?

}
