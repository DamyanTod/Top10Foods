//
//  CoutryCell.swift
//  Top10Foods
//
//  Created by admin on 11/8/15.
//  Copyright © 2015 admin. All rights reserved.
//

import UIKit

class SectionCell : UITableViewCell {
    
    @IBOutlet weak var lblSection: BaseLabel!
    
    @IBOutlet weak var colorFilter: UIView!
    
    @IBOutlet weak var backgroundCountryView: UIImageView!
    
    @IBOutlet weak var recipeImageView: UIImageView!

    @IBOutlet weak var lblSectionCount: BaseLabel!
    
    override func awakeFromNib() {
        
        setLineBettweenCellsToTheEnd()
        
    }
    
    func configurateTheCell (sectionName : String , filterColor : UIColor , sectionRecepiesCount : Int) -> SectionCell {
        
        self.lblSection.setAttributedBaseText(sectionName)
        
        self.lblSection.backgroundColor = filterColor
        
        self.colorFilter.backgroundColor = filterColor
        
        self.lblSectionCount.backgroundColor = filterColor
        
        self.recipeImageView.tintColor = filterColor
        
        self.lblSectionCount.setAttributedBaseText("Recepies \(sectionRecepiesCount)")

        self.backgroundCountryView.image = UIImage(named: "\(sectionName)\(DSTGlobalStringBackground)")
        
        return self
    }
    
    
    func parallaxCellBehavior(tableView : UITableView , view : UIView) {
        
        let rectInSuperView: CGRect = tableView.convertRect(self.frame, toView: view)
        
        let distanceFromCenter = CGRectGetHeight(view.frame) / 2 - CGRectGetMinY(rectInSuperView)
        
        let difference = CGRectGetHeight(backgroundCountryView.frame) - CGRectGetHeight(self.frame)
        
        let move = (distanceFromCenter / CGRectGetHeight(view.frame)) * difference
        
        var imageRect = backgroundCountryView.frame
        
        imageRect.origin.y = -(difference/2) + move
        
        self.backgroundCountryView.frame = imageRect
       
    }
    
    private func setLineBettweenCellsToTheEnd () {
        
        self.separatorInset = UIEdgeInsetsZero
        
        self.preservesSuperviewLayoutMargins = false
        
        self.layoutMargins = UIEdgeInsetsZero
    }

}
