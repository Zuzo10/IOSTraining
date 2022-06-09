//
//  ViewController.swift
//  week2Exam
//
//  Created by Consultant on 6/9/22.
//

import UIKit

class ViewController: UIViewController {
    
    let vc = TableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func tapButton(_ sender: Any) {
        
        vc.listMusic = ["RadioActive" ,"Its Time" ,"Blame" ,"Giant" ,"Lose Yourself", "Memories", "Get Lucky","In my Mind","Im Still Standing","Hey Jude" ]
        vc.imgMusic = [#imageLiteral(resourceName: "Radioactive.jpeg"),#imageLiteral(resourceName: "itsTime.jpeg"),#imageLiteral(resourceName: "Blame.jpeg"),#imageLiteral(resourceName: "Giant.jpeg"),#imageLiteral(resourceName: "LoseYourself.jpeg"),#imageLiteral(resourceName: "Memories.jpeg"),#imageLiteral(resourceName: "GetLucky.jpeg"),#imageLiteral(resourceName: "InMyMind.jpeg"),#imageLiteral(resourceName: "ImStillStanding.jpeg"),#imageLiteral(resourceName: "heyJude.jpeg")]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

