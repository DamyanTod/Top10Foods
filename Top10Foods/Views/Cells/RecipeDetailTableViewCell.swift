//
//  RecipeDetailTableViewCell.swift
//  Top10Foods
//
//  Created by admin on 11/21/15.
//  Copyright © 2015 admin. All rights reserved.
//

import UIKit

class RecipeDetailTableViewCell: UITableViewCell,YALContextMenuCell {

    @IBOutlet weak var menuTitle: BaseLabel!
    @IBOutlet weak var menuImage: UIImageView!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //Mark YALContextMenuCell
    func animatedIcon() -> UIView! {
        return menuImage
    }
    
    func animatedContent() -> UIView! {
        return menuTitle
    }
}

