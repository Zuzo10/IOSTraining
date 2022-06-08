//
//  ViewController.swift
//  exercise4
//
//  Created by Consultant on 6/8/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tabButton(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "myControllerA") as! ViewControllerA
        
        vc.passText = "Hello World"
        present(vc, animated: true,completion: nil)
        
    }
    
}

