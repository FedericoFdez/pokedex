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
    
    var showAll = false
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if showAll{
            self.title = "Todos"
        } else {
            self.title = type!.name
        }
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
        return pokedexModel.NUM_GENERATIONS + 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.showAll{
            switch section{
            case 1: return self.pokedexModel.racesOfGeneration(1).count
            case 2: return self.pokedexModel.racesOfGeneration(2).count
            default:return 1
            }
        }
        
        switch section{
        case 1: return self.type!.racesOfGeneration(1).count
        case 2: return self.type!.racesOfGeneration(2).count
        default:return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            return tableView.dequeueReusableCellWithIdentifier("Switch Cell", forIndexPath: indexPath)
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Race Cell", forIndexPath: indexPath)
        let race : Race
        if self.showAll{
            race = pokedexModel.racesOfGeneration(indexPath.section)[indexPath.row]
        } else {
            race = type!.racesOfGeneration(indexPath.section)[indexPath.row]
        }
        
        cell.imageView?.image = UIImage(named: race.icon)
        cell.textLabel?.text = race.name
        cell.detailTextLabel?.text = race.code
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 1: return "1ª Generación: Kanto"
        case 2: return "2ª Generación: Johto"
        default:return ""
        }
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
                    if self.showAll{
                        wvc.race = pokedexModel.racesOfGeneration(ip.section)[ip.row]
                    } else {
                        wvc.race = type!.racesOfGeneration(ip.section)[ip.row]
                    }
                    
                    wvc.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                    wvc.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    @IBAction func sortByCode(sender: UISwitch) {
        if (sender.on){
            if self.showAll{
                self.pokedexModel.byCode = true
                for (var sectionNumber=1; sectionNumber<pokedexModel.NUM_GENERATIONS + 1; sectionNumber++){
                    for (var rowNumber=0; rowNumber<pokedexModel.racesOfGeneration(sectionNumber).count; rowNumber++){
                        let indexPath = NSIndexPath(forRow: rowNumber, inSection: sectionNumber)
                        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                    }
                }
            } else {
                self.type!.byCode = true
                for (var sectionNumber=1; sectionNumber<pokedexModel.NUM_GENERATIONS + 1; sectionNumber++){
                    for (var rowNumber=0; rowNumber<type!.racesOfGeneration(sectionNumber).count; rowNumber++){
                        let indexPath = NSIndexPath(forRow: rowNumber, inSection: sectionNumber)
                        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                    }
                }
            }
        }
        else {
            if self.showAll{
                self.pokedexModel.byCode = false
                for (var sectionNumber=1; sectionNumber<pokedexModel.NUM_GENERATIONS + 1; sectionNumber++){
                    for (var rowNumber=0; rowNumber<pokedexModel.racesOfGeneration(sectionNumber).count; rowNumber++){
                        let indexPath = NSIndexPath(forRow: rowNumber, inSection: sectionNumber)
                        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                    }
                }
            } else {
                self.type!.byCode = false
                for (var sectionNumber=1; sectionNumber<pokedexModel.NUM_GENERATIONS + 1; sectionNumber++){
                    for (var rowNumber=0; rowNumber<type!.racesOfGeneration(sectionNumber).count; rowNumber++){
                        let indexPath = NSIndexPath(forRow: rowNumber, inSection: sectionNumber)
                        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                    }
                }
            }
        }
    }
    
}
