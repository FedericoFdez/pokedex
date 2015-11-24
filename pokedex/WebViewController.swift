//
//  WebViewController.swift
//  Pokedex
//
//  Created by Santiago Pavón on 11/11/15.
//  Copyright © 2015 UPM. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    // Race a mostrar, o nil para mostrar la pagina Home
    var race: Race?
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // URL a mostrar
        var str = "http://es.pokemon.wikia.com"
        
        if race != nil {
            // Poner nombre de la raza como titulo de la Navigation Bar
            title = race!.name
            
            // Añadir la raza al URL escapando caracteres conflictivos
            if let path = "wiki/\(race!.name)"
                .stringByAddingPercentEncodingWithAllowedCharacters(.URLPathAllowedCharacterSet()) {
                    str = "\(str)/\(path)"
            }
        } else {
            // Poner Pokedex como titulo de la Navigation Bar
            title = "Pokedex"
        }
        
        if let url = NSURL(string: str) {
            let req = NSURLRequest(URL: url)
            webView.loadRequest(req)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
