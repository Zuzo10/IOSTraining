//
//  ViewController.swift
//  calculator
//
//  Created by Consultant on 6/3/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calculatorWorkings: UILabel!
    
    @IBOutlet weak var calculatorResults: UILabel!
    
    var workings:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearAll()
        
    }

    func clearAll(){
        workings=""
        calculatorWorkings.text=""
        calculatorResults.text=""
        
    }
    
    func addToWorkings(value:String){
        
        workings = workings + value
        calculatorWorkings.text = workings
        
    }

    @IBAction func clearAll(_ sender: Any) {
        clearAll()
    }
    @IBAction func porcent(_ sender: Any) {
        
        addToWorkings(value: "%")
    }
    @IBAction func divide(_ sender: Any) {
        addToWorkings(value: "/")
    }
    @IBAction func multiplication(_ sender: Any) {
        addToWorkings(value: "*")
    }
    @IBAction func minus(_ sender: Any) {
        addToWorkings(value: "-")
    }
    @IBAction func plus(_ sender: Any) {
        addToWorkings(value: "+")
    }
    @IBAction func equal(_ sender: Any) {
        
        if validInput(){
            let checkedPercent = workings.replacingOccurrences(of: "%", with: "*0.01")
            let expression = NSExpression(format: checkedPercent)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let resultString = formatResult(result: result)
            calculatorResults.text = resultString
            
        }else{
            
            let alert = UIAlertController(
                title: "Invalid Input",
                message: "Calculator unable to do math.",
                preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            
        }
        
        
    }
    
    func validInput()->Bool{
        
        var count = 0
        var charIndexes = [Int]()
            
        for char in workings{
            
            if specialCharacters(char: char){
                charIndexes.append(count)
            }
            count+=1
        }
        
        var previous: Int = -1
        for index in charIndexes{
            
            if index == 0 {
                return false
            }
            
            if (index == workings.count - 1) {
                return false
            }
            
            if previous != -1 {
                
                if index - previous == 1 {
                    return false
                }
            }
            
            previous = index
            
        }
        
        return true
    }
    
    func specialCharacters(char: Character) -> Bool{
        
        if char == "*" || char == "/" || char == "+" || char == "-"{
            return true
        }else{
            return false
        }
        
    }
    
    func formatResult(result:Double)-> String{
        
        if result.truncatingRemainder(dividingBy: 1) == 0{
             return String(format: "%.0f", result)
        }else{
            return String(format: "%.2f", result)
        }
    }
    @IBAction func decimal(_ sender: Any) {
        addToWorkings(value: ".")
    }
    @IBAction func zero(_ sender: Any) {
        addToWorkings(value: "0")
    }
    @IBAction func one(_ sender: Any) {
        addToWorkings(value: "1")
    }
    @IBAction func two(_ sender: Any) {
        addToWorkings(value: "2")
    }
    @IBAction func three(_ sender: Any) {
        addToWorkings(value: "3")
    }
    @IBAction func four(_ sender: Any) {
        addToWorkings(value: "4")
    }
    @IBAction func five(_ sender: Any) {
        addToWorkings(value: "5")
    }
    @IBAction func six(_ sender: Any) {
        addToWorkings(value: "6")
    }
    @IBAction func seven(_ sender: Any) {
        addToWorkings(value: "7")
    }
    @IBAction func eight(_ sender: Any) {
        addToWorkings(value: "8")
    }
    @IBAction func nine(_ sender: Any) {
        addToWorkings(value: "9")
    }
}

