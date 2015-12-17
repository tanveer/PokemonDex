//
//  ViewController.swift
//  PokemanDex
//
//  Created by Tanveer Bashir on 12/14/15.
//  Copyright © 2015 Tanveer Bashir. All rights reserved.
//

import UIKit
private let IDENTIFIER = "Cell"
class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var images:[String] = []
    var pokemon = [Pokemon]()
    var inSearchMode = false
    var filterdPokemon:[Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        for image in 1...718 {
            images.append("\(image)")
        }
        parseCSV()
    }
    
    @IBAction func unwindToContainerVC(segue: UIStoryboardSegue) {
        
    }
    
    func parseCSV(){
        let file = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do {
            let parsedCVS = try CSV(contentsOfURL: file)
            let rows = parsedCVS.rows
           
            for row in rows {
               pokemon.append(Pokemon(name: row["identifier"]!, pokeId: row["id"]!))
            }
        }
        catch let err as NSError? {
            print("\(err.debugDescription)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filterdPokemon.count
        }
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let poke:Pokemon!
        if inSearchMode {
            poke = filterdPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        performSegueWithIdentifier("detailVC", sender: poke)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(IDENTIFIER, forIndexPath: indexPath) as! CutomeCollectionCell
        let poke:Pokemon!
        if inSearchMode {
            poke = filterdPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        
        cell.configureCell(poke)
        return cell
    }
    
    //display 3 cell on any device in collection view
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
       // return CGSize(width: (collectionView.frame.size.width - 3)/3, height: 100)
        
        return CGSizeMake(105, 105)
    }
    
    //Search
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filterdPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            collectionView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let identifier = "detailVC"
        if segue.identifier == identifier {
            let detailVC  = segue.destinationViewController as! DetailViewController
            detailVC.poke = sender as! Pokemon
        }
    }
}

