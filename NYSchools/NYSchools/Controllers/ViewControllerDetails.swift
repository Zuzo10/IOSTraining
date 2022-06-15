//
//  ViewControllerDetails.swift
//  NYSchools
//
//  Created by Consultant on 6/15/22.
//

import UIKit

class ViewControllerDetails: UIViewController {

    @IBOutlet weak var math: UILabel!
    
    @IBOutlet weak var reading: UILabel!
    
    @IBOutlet weak var writing: UILabel!
    
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var schoolDBN: UILabel!
    
    var data : dataSchool?   //recivedata
    var details = [dataDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schoolName.text = data?.schoolName
        schoolDBN.text = data?.dbn
    
        
        getSchool.shared.fetchDataDetails(dataDbn: data!.dbn){result in
            
            switch result {
            case .success(let detail):
                if detail.count > 0{
                    self.math.text = detail[0].satMathAvgScore
                    self.reading.text = detail[0].satCriticalReadingAvgScore
                    self.writing.text = detail[0].satWritingAvgScore
                }else{
                    self.math.text = "No Data"
                    self.reading.text = "No Data"
                    self.writing.text = "No Data"
                }
            case .failure(let error):
                print(error.localizedDescription)
               
            }
            
           
        }
        
    }
    
    

}
