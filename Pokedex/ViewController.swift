//
//  ViewController.swift
//  Pokedex
//
//  Created by Uldis Zingis on 11/10/16.
//  Copyright © 2016 Uldis Zingis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var moveLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        PokemonController.fetchPokemon(for: searchTerm) { (pokemon) in
            guard let pokemon = pokemon else { return }
            DispatchQueue.main.async {
                self.updateWith(pokemon: pokemon)
            }
        }
    }
    
    func updateWith(pokemon: Pokemon) {
        ImageController.image(forURL: pokemon.pictureURL, completion: { (image) in
            self.imageView.image = image
        })
        
        let formattedString = NSMutableAttributedString()
        nameLabel.attributedText = formattedString.normal(text: "Name: ").bold(text: pokemon.name.capitalized)
        moveLabel.text = "Move: " + pokemon.moveName.capitalized
        typeLabel.text = "Type: " + pokemon.type.capitalized
    }
}

extension NSMutableAttributedString {
    func bold(text:String) -> NSMutableAttributedString {
        let attrs:[String:AnyObject] = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 17.0) ]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    func normal(text:String)->NSMutableAttributedString {
        let normal =  NSAttributedString(string: text)
        self.append(normal)
        return self
    }
}
