//
//  ViewController.swift
//  RickyAndMortyAPI
//
//  Created by Consultant on 6/14/22.
//

import UIKit

class ViewController: UIViewController {
    
    var dataApi = [apiRM]()
    
    @IBOutlet weak var tableviewRM: UITableView!
    
    var data: String?
    

   override func viewDidLoad() {
        
        super.viewDidLoad()
        setupData()
        fetchData()
        
    }
    
    
    private func setupData(){
        tableviewRM.delegate = self
        tableviewRM.dataSource = self
        
    }
   
    func fetchData(){
        
            
           let data = structConnect()
        //let jsonArray2 : [Any] = data.connAPI(url : "https://rickandmortyapi.com/api/character/?status=alive")
        
        
        data.connAPI(url : "https://rickandmortyapi.com/api/character/?status=alive"){result in
            
            guard let jsonArray2 =  result as? [Any] else {
                print("ERROR2")
                return }
            
            for character in jsonArray2{
                    guard let apiDict = character as? [String:Any] else { return }
                    guard let name = apiDict["name"] as? String else { return }
                    guard let status = apiDict["status"] as? String else { return }
                    guard let species = apiDict["species"] as? String else { return }
                    guard let img =  apiDict["image"] as? String else { return }
                    self.dataApi.append(apiRM(name: name,status: status,species: species, img: img ))
                    
                    DispatchQueue.main.async {
                        self.tableviewRM.reloadData()
                    }
                }
            
        }
        
        
        
    }
    
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataApi.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableviewRM.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = dataApi[indexPath.row].name
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let dataSel = dataApi[indexPath.row].name
        
        let vcDetails = storyboard?.instantiateViewController(identifier: "details") as! ViewControllerDetails
        vcDetails.details = dataApi[indexPath.row]
        self.navigationController?.show(vcDetails, sender: nil)
        //self.performSegue(withIdentifier: "send", sender: dataSel)
        
    }
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "send" {
            let to = segue.destination as? ViewControllerDetails
            to?.details = sender as? String
        }
    }*/
    
    
}
