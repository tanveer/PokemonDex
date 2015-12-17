//
//  DetailViewController.swift
//  PokemanDex
//
//  Created by Tanveer Bashir on 12/15/15.
//  Copyright © 2015 Tanveer Bashir. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var poke: Pokemon!
    
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var defense: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var attack: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var bottomImage1: UIImageView!
    @IBOutlet weak var bottomImage2: UIImageView!
    @IBOutlet weak var nextEvolutionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        poke.downloadPokemon(){
            self.updateUI()
        }
    }
    
    func updateUI(){
        weight.text = poke.weight
        height.text = poke.height
        id.text = poke.id
        descriptionLabel.text = poke.description
        defense.text = poke.defense
        attack.text = poke.attack
        type.text = poke.types
        descriptionLabel.text = poke.description
        bottomImage1.image = UIImage(named: "\(poke.pokeId)")
        print(poke.nextEvo)
        bottomImage2.image = UIImage(named: poke.nextEvo)
        pokemonNameLabel.text = poke.name.capitalizedString
        displayImage.image = UIImage(named: "\(poke.pokeId)")
        let evolutionLabel = "Next Evolution: \(poke.nextEvoName), Level:\(poke.nextEvoLevel)"
        nextEvolutionLabel.text = evolutionLabel
    }
    
}
