//
//  ViewControllerDetails.swift
//  PokemonAPI
//
//  Created by Consultant on 6/18/22.
//

import UIKit

class ViewControllerDetails: UIViewController {
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    var detail : Int = 0// mainPokemon!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(detail.id).png")
        
        let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(detail).png")
        
       img.getImage(from: url!)
        
        
       
    }
    
    
    

}
