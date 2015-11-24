//
//  RacesTableViewController.swift
//  Pokedex
//
//  Created by Santiago Pavón on 11/11/15.
//  Copyright © 2015 UPM. All rights reserved.
//

import UIKit

class TypeRacesTableViewController: UITableViewController {
    
    // Type a mostrar, o nil para mostrar la pagina Home
    var type: Type?
    
    var pokedexModel = PokedexModel()    
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = type!.name
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
        return type!.races.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            return tableView.dequeueReusableCellWithIdentifier("Switch Cell", forIndexPath: indexPath)
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Race Cell", forIndexPath: indexPath)
        
        let race = type!.races[indexPath.row-1]
        
        cell.imageView?.image = UIImage(named: race.icon)
        cell.textLabel?.text = race.name
        cell.detailTextLabel?.text = race.code
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Show Web Info" {
            
            // El destino del segue es el Navigation Controller.
            // El primer VC apuntado por el Navigation Controller el WebVC.
            // sender es la celda de la tabla que disparo el segue.
            if let nc = segue.destinationViewController as? UINavigationController,
                let wvc = nc.topViewController as? WebViewController,
                let cell = sender as? UITableViewCell,
                let ip = tableView.indexPathForCell(cell) {
                    
                    wvc.race = type!.races[ip.row-1]
                    
                    wvc.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                    wvc.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    @IBAction func sortByCode(sender: UISwitch) {
        if (sender.on){
            pokedexModel.byCode = true

            for type in pokedexModel.types{
                if type.name == self.type!.name{
                    self.type = type
                    break
                }
            }
            for (var rowNumber=1; rowNumber<type!.races.count + 1; rowNumber++){
                let indexPath = NSIndexPath(forRow: rowNumber, inSection: 0)
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
            
            //tableView.reloadData()
        }
        else {
            pokedexModel.byCode = false
            
            for type in pokedexModel.types{
                if type.name == self.type!.name{
                    self.type = type
                    break
                }
            }
            for (var rowNumber=1; rowNumber<type!.races.count + 1; rowNumber++){
                let indexPath = NSIndexPath(forRow: rowNumber, inSection: 0)
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
    }
    
}
