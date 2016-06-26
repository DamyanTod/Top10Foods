//
//  RecipeDetailViewController.swift
//  Top10Foods
//
//  Created by admin on 11/12/15.
//  Copyright © 2015 admin. All rights reserved.
//

import UIKit

class RecipeDetailViewController : UIViewController {
    
    @IBOutlet weak var detailRecipeText: UITextView!

    private var menuItems = [ItemsForHiddenMenu]()
    
    private lazy var contextMenuTableView = YALContextMenuTableView()
    
    var section: SectionType?
    
    var recipe:Recepies?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(title: "Recipe Info", style: .Plain , target: self, action: #selector(RecipeDetailViewController.pressedAddButton(_:)))
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = UIColor.defaultBackgroundColor()
        
        if let recipe = recipe ,
            text = recipe.ingredients ,
            sectionName = section?.name,
            recipeName = recipe.name,
            type = recipe.type,
            servingPeople = recipe.serving,
            minutes = recipe.time,
            difficulty = recipe.level {
                
                menuItems.append(ItemsForHiddenMenu(icon: DSTGlobalImageClose, text: "exit"))
                menuItems.append(ItemsForHiddenMenu(icon: DSTGlobalImageCountry , text: sectionName))
                menuItems.append(ItemsForHiddenMenu(icon: DSTGlobalImageRecipe , text: recipeName))
                menuItems.append(ItemsForHiddenMenu(icon: type , text: type))
                menuItems.append(ItemsForHiddenMenu(icon: DSTGlobalImagePeople , text: "\(servingPeople)"))
                menuItems.append(ItemsForHiddenMenu(icon: DSTGlobalImageClock , text: "\(minutes)"))
                menuItems.append(ItemsForHiddenMenu(icon: DSTGlobalImageChef , text: difficulty))
                
                let tabbedString = text.stringByReplacingOccurrencesOfString("©", withString: "\n", options: NSStringCompareOptions.LiteralSearch, range: nil)
                
                detailRecipeText.text = tabbedString
                
        }
    }
    
    
    @IBAction func pressedAddButton (sender : UIBarButtonItem) {
        
        contextMenuTableView.contentInset = UIEdgeInsetsMake(+30, -10, 0, 0);
        contextMenuTableView.dataSource = self
        contextMenuTableView.delegate = self
        contextMenuTableView.animationDuration = 0.10
        contextMenuTableView.menuItemsSide = .Right
        contextMenuTableView.menuItemsAppearanceDirection = .FromTopToBottom
        
        let cell = UINib(nibName: DSTRecipeDetailTableViewCellIdentifier, bundle: nil)
        contextMenuTableView.registerNib(cell, forCellReuseIdentifier: DSTRecipeDetailTableViewCellIdentifier)

        contextMenuTableView.showInView(self.navigationController?.view, withEdgeInsets: UIEdgeInsetsZero, animated: true)
    
    }
 
}

private struct ItemsForHiddenMenu {
    var icon = ""
    var text = ""
}

extension RecipeDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.contextMenuTableView.dismisWithIndexPath(indexPath)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if let recipeDetailCell = tableView.dequeueReusableCellWithIdentifier(DSTRecipeDetailTableViewCellIdentifier, forIndexPath: indexPath) as? RecipeDetailTableViewCell {
            
            recipeDetailCell.menuTitle.text = menuItems[indexPath.row].text
            recipeDetailCell.menuImage.image = UIImage(named: menuItems[indexPath.row].icon)
            
            cell = recipeDetailCell
        
        }
        
        return cell
    }
}



