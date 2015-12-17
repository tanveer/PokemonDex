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
    @IBOutlet weak var evolutionLabel: UILabel!
    @IBOutlet weak var bottomImage2: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        poke.downloadPokemon()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        weight.text = poke.weight
        height.text = poke.height
        id.text = poke.id
        descriptionLabel.text = poke.description
        defense.text = poke.defense
        attack.text = poke.attack
        type.text = poke.types
        descriptionLabel.text = poke.description
        bottomImage1.image = UIImage(named: poke.nextEvo)
        displayImage.image = UIImage(named: "\(poke.pokeId)")
        //bottomImage1.image =
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
