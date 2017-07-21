//
//  Item+CoreDataClass.swift
//  WishList
//
//  Created by Pragun Sharma on 20/07/17.
//  Copyright © 2017 Pragun Sharma. All rights reserved.
//

import Foundation
import CoreData

public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        
        super.awakeFromInsert()
        self.created = NSDate()
    }
}
