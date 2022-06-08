//
//  ViewControllerSender.swift
//  exercise4_4
//
//  Created by Consultant on 6/8/22.
//

import UIKit

protocol sendText{
    func updateText(withText text : String)
}

class ViewControllerSender: UIViewController {

    var delegate : sendText?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
    @IBOutlet weak var edtText: UITextField!
    
    @IBAction func btnSender(_ sender: UIButton) {
        delegate?.updateText(withText: edtText.text ?? "")
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
