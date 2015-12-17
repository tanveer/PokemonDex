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
    private var _pokeId: Int!
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

    
    var name:String {
        if _name != nil {
            return _name
        }
        return emptyString
    }
    
    var pokeId:Int {
        return _pokeId
    }
    
    var weight:String {
        if _weight != nil {
            return _weight
        }
        return emptyString
    }
    
    var height:String {
        if _height != nil {
            return _height
        }
        return emptyString
    }
    
    var id:String {
        if _id != nil {
            return "\(_id)"
        }
        return emptyString
    }
    
    var defense:String{
        if _defense != nil {
            return _defense
        }
        return emptyString
    }
    
    var attack:String{
        if let attack = _attack {
            return attack
        }
        return emptyString
    }
    
    var types:String{
        if let types = _types{
            return types
        }
        return emptyString
    }
    
    var nextEvo:String {
        if let nextEvo = _nextEvoution{
            return nextEvo
        }
        return emptyString
    }
    
    var description:String{
        if let description = _description{
            return description
        }
         return emptyString
    }
    
    init(name:String, pokeId:Int){
        _name = name
        _pokeId = pokeId
        _pokemonURL = "\(BASE_URL)\(API_URL)\(self._pokeId)/"
    }
    
    func downloadPokemon(){
        let nsURL = NSURL(string: _pokemonURL)
        Alamofire.request(.GET, nsURL!).responseJSON {
            response in
            if let result = response.result.value as? [String:AnyObject] {
                if let height = result["height"] as? String,
                    let weight = result["weight"] as? String{
                        self._weight = weight
                        self._height = height
                }
                
                if let id = result["id"] as? Int{
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
                    }
                }
                
                //get next evolutions
                if let evolutions = result["evolutions"] as? [[String:AnyObject]]
                    where evolutions.count > 0,
                    let nextEvo = evolutions[0]["to"] as? String {
                    if nextEvo.rangeOfString("mega") == nil,
                        let nextEvolutionID = evolutions[0]["resource_uri"] as? String {
                        let id = nextEvolutionID.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "").stringByReplacingOccurrencesOfString("/", withString: "")
                        self._nextEvoution = id
                    }
                }
                
            }
        }
    }
}