//
//  ViewControllerDetails.swift
//  week2Exam
//
//  Created by Consultant on 6/9/22.
//

import UIKit

class ViewControllerDetails: UIViewController {
    
    var titleMusic : String?
    var img : UIImage?
    var num : Int?
    var desc : String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       switch num {
        
        case 0:
            desc = "Radioactive - Imagine Dragons"
        case 1:
            desc = "Its Time - Imagine Dragons"
        case 2:
            desc = "Blame - Calvin Harris"
        case 3:
            desc = "Giant - Calvin Harris"
        case 4:
           desc = "Lose Yourself - Eminem"
        case 5:
           desc = "Memories - David Guetta"
        case 6:
           desc = "Get Lucky - Daft Punk"
        case 7:
           desc = "In my Mind - Dynoro"
        case 8:
           desc = "Im Still Standing - Taron Egerton"
        case 9:
           desc = "Hey Jude - The Beattles"
        default :
            desc = "nothing selected"
        }
        
        labelTitle?.text = titleMusic
        imgMusic?.image = img
        labelDescription.text = desc
       // print(numRegister)
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var imgMusic: UIImageView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
