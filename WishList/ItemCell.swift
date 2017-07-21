//
//  ItemCell.swift
//  WishList
//
//  Created by Pragun Sharma on 20/07/17.
//  Copyright © 2017 Pragun Sharma. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

 
    @IBOutlet weak var thumbIcon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var price: UILabel!
    
    func configureCell(item: Item) {
        title.text = item.title
        price.text = "$\(item.price)"
        details.text = item.details
    }
}
