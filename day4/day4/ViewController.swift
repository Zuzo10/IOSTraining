//
//  ViewController.swift
//  day4
//
//  Created by Consultant on 6/7/22.
//

import UIKit

class ViewController: UIViewController {
    
    let myVC = TableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func tapButton(_ sender: Any) {
        
        myVC.content = ["content 1","content 2","content 3","content 4"]
        navigationController?.pushViewController(myVC, animated: true)
    }
}

