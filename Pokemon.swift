//
//  Pokemon.swift
//  PokemanDex
//
//  Created by Tanveer Bashir on 12/14/15.
//  Copyright © 2015 Tanveer Bashir. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokeId: String!
    private var _pokemonURL: String!
    private var _displayImage: String!
    private var _description: String!
    private var _types: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _id: String!
    private var _evolutionTxt:String!
    private let emptyString = ""
    private var _nextEvoution:String!
    private var _nextEvoName:String!
    private var _nextEvoLevel:String!

    //computed properties
    var name:String {
        if _name == nil {
            _name = emptyString
        }
        return _name
    }
    
    var pokeId:String {
        if _pokeId == nil {
            _pokeId = emptyString
        }
        return _pokeId
    }
    
    var weight:String {
        if _weight == nil {
            _weight = emptyString
        }
        return _weight
    }
    
    var height:String {
        if _height == nil {
            _height = emptyString
        }
        return _height
    }
    
    var id:String {
        if _id == nil {
            _id = emptyString
        }
        return _id
    }
    
    var defense:String{
        if _defense == nil {
            _defense = emptyString
        }
        return _defense
    }
    
    var attack:String {
        if _attack == nil {
            _attack = emptyString
        }
        return _attack
    }
    
    var types:String {
        if _types == nil {
           _types = emptyString
        }
        return _types
    }
    
    var nextEvo:String {
        if _nextEvoution == nil {
            _nextEvoution = emptyString
        }
        return _nextEvoution
    }
    
    var nextEvoName:String{
        if _nextEvoName == nil {
            _nextEvoName = "none"
        }
        return _nextEvoName
    }
    var nextEvoLevel:String{
        if _nextEvoLevel == nil {
            _nextEvoLevel = "??"
        }
        return _nextEvoLevel
    }
    
    var description:String{
        if _description == nil {
            _description = emptyString
        }
         return _description
    }
    
    init(name:String, pokeId:String){
        _name = name
        _pokeId = pokeId
        _pokemonURL = "\(BASE_URL)\(API_URL)\(self._pokeId)/"
    }
    
    func downloadPokemon(completed: DownloadComlete){
        let nsURL = NSURL(string: _pokemonURL)
        Alamofire.request(.GET, nsURL!).responseJSON {
            response in
            if let result = response.result.value as? [String:AnyObject] {
                if let height = result["height"] as? String,
                    let weight = result["weight"] as? String{
                        self._weight = weight
                        self._height = height
                }
                
                if let id = result["pkdx_id"] as? Int{
                    self._id = "\(id)"
                    
                }
                
                if let defense = result["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let attack = result["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let description = result["description"] as? String{
                    self._description = description
                }
                
                if let types = result["types"] as? [[String:String]] where types.count > 0 {
                    
                    if let type = types[0]["name"]{
                        self._types = " \(type.capitalizedString)"
                    }
                    
                    for type in types {
                        if self._types.containsString(type["name"]!.capitalizedString) {
                        } else {
                            self._types! += "/\(type["name"]!)".capitalizedString
                        }
                    }
                }
                
                //get next evolutions
                if let evolutions = result["evolutions"] as? [[String:AnyObject]]
                    where evolutions.count > 0 {
                    if let nextEvo = evolutions[0]["to"] as? String {
                        if nextEvo.rangeOfString("mega") == nil {
                            let nextEvolutionID = evolutions[0]["resource_uri"] as? String
                            let level = evolutions[0]["level"] as? Int
                            let id = nextEvolutionID!.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "").stringByReplacingOccurrencesOfString("/", withString: "")
                            self._nextEvoution = id
                            self._nextEvoName = nextEvo
                            if let lvl = level {
                                self._nextEvoLevel = "\(lvl)"
                            }
                            
                        }
                    }
                }
        
                if let description = result["descriptions"] as? [[String:String]],
                   let uri = description[0]["resource_uri"] {
                    //NSURL
                    let url = NSURL(string:"\(BASE_URL)\(uri)")!
                    //fetch data from internet
                    Alamofire.request(.GET, url).responseJSON {
                        response in
                        if let result = response.result.value as? [String:AnyObject] {
                            if let description = result["description"] as? String {
                                self._description = description
                            }
                        }
                        completed()
                    }
                }
            }
        }
    }
}