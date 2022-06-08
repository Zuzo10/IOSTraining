//
//  ViewControllerA.swift
//  exercise4
//
//  Created by Consultant on 6/8/22.
//

import UIKit

class ViewControllerA: UIViewController {
    
    var passText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myLabel?.text = passText
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var myLabel: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
