//
//  ViewControllerDetails.swift
//  RickyAndMortyAPI
//
//  Created by Consultant on 6/14/22.
//

import UIKit

class ViewControllerDetails: UIViewController {

    @IBOutlet weak var txtLabel: UILabel!
    
    @IBOutlet weak var txtLabel2: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var txtLabel3: UILabel!
    
    var details : apiRM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let url = URL(string: details!.img)
        let data = try? Data(contentsOf: url!) 
        
        img.image = UIImage(data: data!)
        txtLabel.text = details?.name
        txtLabel2.text = details?.status
        txtLabel3.text = details?.species
    }
    

    
}
