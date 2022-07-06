//
//  ViewController.swift
//  FinalProject
//
//  Created by Consultant on 7/5/22.
//

import UIKit

class ViewController: UIViewController {

    var sportsList = [listSports]()
    
    @IBOutlet weak var tableViewSports: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        setupDelegates()
    
    }
    
    
    func setupDelegates(){
        self.tableViewSports.delegate = self
        self.tableViewSports.dataSource = self
        fetchSports()
        
    }
    
    func fetchSports(){
     
        activityIndicator.startAnimating()
        NetworkingProvider.shared.getSport { sports in
            
            self.sportsList = sports
            print(self.sportsList)
            self.activityIndicator.stopAnimating()
            
            DispatchQueue.main.async {
                self.tableViewSports.reloadData()
            }
            
        }failure: { error in
            self.activityIndicator.stopAnimating()
        }
        
    }


}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sportsList[indexPath.row].title
        cell.detailTextLabel?.text = sportsList[indexPath.row].sportDescription
        return cell
    }
    
    
    
}
