//
//  ViewController.swift
//  exercise4_4
//
//  Created by Consultant on 6/8/22.
//

import UIKit

class ViewController: UIViewController, sendText {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _ = segue.destination as! ViewControllerSender
       
        if segue.identifier == "goToSender"{
            let des = segue.destination as! ViewControllerSender
            des.delegate = self
        }
        
    }
    
    func updateText(withText text: String) {
        labelRec.text = text
    }
    @IBOutlet weak var labelRec: UILabel!
}
