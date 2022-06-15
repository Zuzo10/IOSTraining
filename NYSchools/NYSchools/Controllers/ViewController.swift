//
//  ViewController.swift
//  NYSchools
//
//  Created by Consultant on 6/15/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableviewSchools: UITableView!
    var schools = [dataSchool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }

    func setupTableView(){
        tableviewSchools.delegate = self
        tableviewSchools.dataSource = self
        
        getSchool.shared.fetchData(url: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"){ result in

            switch result {
            case .success(let sch):
                self.schools.append(contentsOf: sch)
                self.tableviewSchools.reloadData()
               
            case .failure(let error):
                print(error.localizedDescription)
               
            }

        }
        
    }
    
  

}




extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text =  schools[indexPath.row].schoolName.capitalized
        cell.detailTextLabel?.text = schools[indexPath.row].dbn
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueDetails", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
            if let dest = segue.destination as? ViewControllerDetails {
            
                dest.data = schools[(tableviewSchools.indexPathForSelectedRow?.row)!]
            
            }
    }
    
}
