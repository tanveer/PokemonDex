//
//  CutomeCollectionCell.swift
//  PokemanDex
//
//  Created by Tanveer Bashir on 12/14/15.
//  Copyright © 2015 Tanveer Bashir. All rights reserved.
//

import UIKit

class CutomeCollectionCell: UICollectionViewCell {
    @IBOutlet weak var image:UIImageView!
    @IBOutlet weak var nameLabel:UILabel!
    
    var pokemon: Pokemon!
    func configureCell(pokemon: Pokemon){
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalizedString
        image.image = UIImage(named: "\(self.pokemon.pokeId)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5
    }
}
