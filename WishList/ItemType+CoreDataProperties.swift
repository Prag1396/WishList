//
//  ItemType+CoreDataProperties.swift
//  WishList
//
//  Created by Pragun Sharma on 20/07/17.
//  Copyright © 2017 Pragun Sharma. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType")
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
