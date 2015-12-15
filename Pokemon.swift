//
//  Pokemon.swift
//  PokemanDex
//
//  Created by Tanveer Bashir on 12/14/15.
//  Copyright © 2015 Tanveer Bashir. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokeId: Int!
    
    var name:String{
        return _name
    }
    var pokeId:Int {
        return _pokeId
    }
    
    init(name:String, pokeId:Int){
        _name = name
        _pokeId = pokeId
    }
}