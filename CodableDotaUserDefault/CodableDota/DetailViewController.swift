//
//  DetailViewController.swift
//  CodableDota
//
//  Created by Admin on 6/15/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var attributesLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var legsLbl: UILabel!
    
    var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = hero?.name
        attackLbl.text = hero?.primaryAttribute
        attackLbl.text = hero?.attackType
        legsLbl.text = "\((hero?.legs)!)"
        let baseURL = "https://api.opendota.com" + (hero?.image)!
        let url = URL(string: baseURL)
        image.getImage(from: url!)
      
    }

}
