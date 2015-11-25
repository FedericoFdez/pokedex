//
//  Type.swift
//  Pokedex
//
//  Created by Santiago Pavón on 26/11/14.
//  Copyright (c) 2014 UPM. All rights reserved.
//

import Foundation

/**
 * Clase para representar un tipo de pokemon.
 * A un tipo de pokemon pertenecen varias razas.
 */
class Type {
    
    // Nombre del tipo (agua, fuego, electrico, ...)
    var name: String
    
    // Nombre del fichero con el icono del pokemon más representativo del tipo.
    var icon: String
    
    // Todas las razas de este tipo.
    var races: [Race]
    
    var byCode: Bool {
        didSet{
            if oldValue==false{
                races.sortInPlace({ (race1:Race, race2:Race) -> Bool in
                    return Int(race1.code) < Int(race2.code)
                })
            }
            else {
                races.sortInPlace({ (race1:Race, race2:Race) -> Bool in
                    return race1.name < race2.name
                })
            }
        }
    }

    
    // Inicializador de la clase Type
    init(name: String, icon: String, races: [Race], byCode: Bool) {
        
        self.name = name
        self.icon = icon
        self.races = races
        self.byCode = false
    }
    
    func racesOfGeneration(generation: Int) -> [Race]{
        var racesOfGeneration: [Race] = []
        for race in self.races{
            if Int(race.code)<=151 && generation==1 {
                racesOfGeneration.append(race)
            } else if Int(race.code)>151 && generation==2 {
                racesOfGeneration.append(race)
            }
        }
        return racesOfGeneration
    }
    
}
