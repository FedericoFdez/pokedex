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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokedexModel.types.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Type Cell", forIndexPath: indexPath)
        
        let type = pokedexModel.types[indexPath.row]
        
        cell.imageView?.image = UIImage(named: type.icon)
        cell.textLabel?.text = type.name
        //cell.detailTextLabel?.text = type.name
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Show races" {
            
            // El destino del segue es el Navigation Controller.
            // El primer VC apuntado por el Navigation Controller el TypeRacesTableVC.
            // sender es la celda de la tabla que disparo el segue.
            if let nc = segue.destinationViewController as? UINavigationController,
                let rvc = nc.topViewController as? TypeRacesTableViewController,
                let cell = sender as? UITableViewCell,
                let ip = tableView.indexPathForCell(cell) {
                    
                    rvc.type = pokedexModel.types[ip.row]
                    
                    rvc.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                    rvc.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}
