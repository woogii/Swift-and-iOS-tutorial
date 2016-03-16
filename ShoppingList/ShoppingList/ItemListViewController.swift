//
//  ViewController.swift
//  ShoppingList
//
//  Created by Hyun on 2016. 3. 12..
//  Copyright © 2016년 wook2. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController, ItemAddViewControllerDelegate {

    // MARK : - Property
    @IBOutlet weak var tableView: UITableView!
    
    
    var appDelegate : AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    let cellIdentifier = "itemCell"
    
    // MARK : - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        appDelegate.items.append(Item(price: 5000, name: "banana"))
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func configureUI() {
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addItem:")
        //let editButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "editItem:")
        
        self.navigationItem.leftBarButtonItem = addButton
        self.navigationItem.rightBarButtonItem = editButtonItem()
        

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

 
    func addItem(barButtonItem: UIBarButtonItem) {
        //let controller = self.storyboard?.instantiateViewControllerWithIdentifier("ItemAddViewController")
        // as! ItemAddViewController
        // presentViewController(controller, animated: true, completion: nil)
        performSegueWithIdentifier("showAddView", sender: self)
    }
    
    func addItemInList(controller: ItemAddViewController, item: Item) {
        appDelegate.items.append(item)
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if( segue.identifier == "showAddView") {
            
            let naviController = segue.destinationViewController as! UINavigationController
            let itemAddViewController = naviController.topViewController as! ItemAddViewController
            itemAddViewController.delegate = self
            
        } else if ( segue.identifier == "showDetailView") {
            
            let controller = segue.destinationViewController as! ItemDetailViewController

            if let indexPath = sender as? NSIndexPath {
             
                print(indexPath.row)
                controller.item = Item(price: appDelegate.items[indexPath.row].price, name: appDelegate.items[indexPath.row].name)
            }
            
        }
    }
    
}

extension ItemListViewController : UITableViewDelegate, UITableViewDataSource {
  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel!.text = appDelegate.items[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            appDelegate.items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {

        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if cell?.imageView?.image == nil {
            cell?.imageView?.image = UIImage(named: "checkmark")
        } else {
            cell?.imageView?.image = nil
        }
        
        
    }
    
    // Tell the delegate that the user tapped the accessory (disclosure) view associated with a given row
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {

        performSegueWithIdentifier("showDetailView", sender: indexPath)
    }
    
    // Toggle the table view into and out of editing mode
    override func setEditing(editing: Bool, animated: Bool) {
        tableView.setEditing(editing, animated: animated)
        super.setEditing(editing, animated: animated)
    }
    

}
