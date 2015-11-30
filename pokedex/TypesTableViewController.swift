//
//  TypesTableViewController.swift
//  pokedex
//
//  Created by Federico Fernández on 24/11/15.
//  Copyright © 2015 Federico Fernández. All rights reserved.
//

import UIKit

class TypesTableViewController: UITableViewController {
    
    var pokedexModel = PokedexModel()
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0{
            return 1
        }
        return pokedexModel.types.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Type Cell", forIndexPath: indexPath)
        
        if (indexPath.section==0){
            cell.textLabel?.text = "Todos"
            cell.imageView?.image = UIImage(named: "pokeball.png")
            return cell
        }
        
        let type = pokedexModel.types[indexPath.row]
        
        cell.imageView?.image = UIImage(named: type.icon)
        cell.textLabel?.text = type.name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section==1{
            return "Por tipo"
        }
        return ""
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Show races" {
            
            // El destino del segue es el TypeRacesTableVC.
            // sender es la celda de la tabla que disparo el segue.
            if let rvc = segue.destinationViewController as? TypeRacesTableViewController,
                let cell = sender as? UITableViewCell,
                let ip = tableView.indexPathForCell(cell) {
                    
                    if ip.section==0{
                        rvc.showAll = true
                    } else {
                        rvc.type = pokedexModel.types[ip.row]
                    }
                    
                    rvc.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}
