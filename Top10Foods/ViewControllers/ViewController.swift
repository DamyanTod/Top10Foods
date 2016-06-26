//
//  ViewController.swift
//  Top10Foods
//
//  Created by admin on 11/8/15.
//  Copyright © 2015 admin. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let db = DatabaseManager.sharedDatabase
    
    private var sections: [SectionType]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private var sectionColors: [UIColor]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        db.parseRecepiesIfNeeded()
        
        tableView.registerNib(UINib(nibName: DSTSectionCellIdentifier, bundle: NSBundle.mainBundle()), forCellReuseIdentifier: DSTSectionCellIdentifier)
        
        if let font = UIFont.defaultFont(18.0) {
                
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.blackColor()]
            
            self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
            
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 1/255.0, green: 169/255.0, blue: 231/255.0, alpha: 1)
            
            self.navigationController?.navigationBar.titleTextAttributes = ColorEnum.getColorForEnum(.WhiteColor)
            
        }
        
        if let sections:[SectionType] = db.getSectionTypes() {
            
            self.sectionColors = SectionType.getColors(sections)
            
            self.sections = sections;
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.alpha = 1
        tableView.backgroundColor = UIColor.defaultBackgroundColor()
    }

}


extension ViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var result = UITableViewCell()
        
        if let sectionCell = tableView.dequeueReusableCellWithIdentifier(DSTSectionCellIdentifier , forIndexPath: indexPath) as? SectionCell,
            let sectionName = sections?[indexPath.row].name {
            
            let numberOfRecepies = sections?[indexPath.row].recepies?.count ?? 0
            let color = sectionColors?[indexPath.row] ?? UIColor(red: 1/255.0, green: 169/255.0, blue: 231/255.0, alpha: 1)
            
            result = sectionCell.configurateTheCell(sectionName, filterColor: color , sectionRecepiesCount: numberOfRecepies)
            
        }
        return result
    }
//Deprecated parallax
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//
//        for cell in self.tableView.visibleCells {
//            if let cell = cell as? SectionCell {
//                cell.parallaxCellBehavior(tableView, view: self.view)
//                
//            }
//        }
//    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {  return sections?.count ?? 0 }
  
    func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1 }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let target = self.storyboard?.instantiateViewControllerWithIdentifier(DSTRecipeTableViewControllerIdentifier) as? RecipeTableViewController ,
            controller = self.navigationController,
            sections = sections {
            
                target.section = sections[indexPath.row]
            
                controller.pushViewController(target, animated: true)
                
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                
        }
    }
    
    
    func tableView(tableView: UITableView, willBeginEditingRowAtIndexPath indexPath: NSIndexPath) {
        
        if let sectionCell = tableView.dequeueReusableCellWithIdentifier(DSTSectionCellIdentifier , forIndexPath: indexPath) as? SectionCell{
    
            sectionCell.layoutSubviews()
            
        }

    }
    
    
    
    

    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        
    }
    
}







