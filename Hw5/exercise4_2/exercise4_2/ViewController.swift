//
//  ViewController.swift
//  exercise4_2
//
//  Created by Consultant on 6/8/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let segueDestination = segue.destination as! ViewControllerB
        segueDestination.passTextSegue = "Hello World"
    }
    

}

