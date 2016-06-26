//
//  RecipeTableViewController.swift
//  Top10Foods
//
//  Created by admin on 11/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

import UIKit

class RecipeTableViewController: UIViewController {
    
    private var recepies: [Recepies]?
    
    private var barColor:UIColor?
    
    var section : SectionType?
    
    @IBOutlet weak var recipeTableView: UITableView!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerImage: UIImageView!

    @IBOutlet weak var sectionNameLbl: BaseLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recepies = self.getRecipesForSection(section)
        setUI()
        self.barColor = SectionType.getColors([section!])[0] ?? UIColor.whiteColor()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.alpha = 0.3
    }
    
    private func setUI () {
        tableView.backgroundColor = UIColor.defaultBackgroundColor()
        
        if let sectionName = section?.name {
            sectionNameLbl.text = sectionName
            headerImage.image = UIImage(named: "\(sectionName)\(DSTGlobalStringBackground)")
        }
 
    }
    
    private func getRecipesForSection (section : SectionType?) -> [Recepies] {
        
        var result = [Recepies]()
        
        if let section = section,
            let recepies =  section.recepies?.allObjects as? [Recepies] {
            result.appendContentsOf(recepies)
        }

        return result
    }
}



extension RecipeTableViewController : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var result = UITableViewCell()
        
        if let recipeCell = tableView.dequeueReusableCellWithIdentifier(DSTRecepiesCellIdentifier) as? RecepiesCell,
            recepies = recepies,
            name = recepies[indexPath.row].name,
            time = recepies[indexPath.row].time,
            type = recepies[indexPath.row].type {
                
                recipeCell.mainInfoLbl.text = "\(name)\n\(type)"
                recipeCell.timingLbl.text = "\(time)"
                recipeCell.typeImage.image = UIImage(named: type)
                result = recipeCell
        }
        
        return result
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return recepies?.count ?? 0
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let target = self.storyboard?.instantiateViewControllerWithIdentifier(DSTRecipeDetailViewControllerIdentifier) as? RecipeDetailViewController ,
            controller = self.navigationController ,
            recepies = recepies {

                target.recipe = recepies[indexPath.row]
            
                target.section = self.section
                
                controller.pushViewController(target, animated: true)
                
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
      
        }
    }
}
