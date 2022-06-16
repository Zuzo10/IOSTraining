//
//  ViewController.swift
//  APIMovies
//
//  Created by Consultant on 6/16/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableViewTopRate: UITableView!
    
    var top : request?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        getDataTop()
    }

    func setupDelegates(){
        tableViewTopRate.dataSource = self
        tableViewTopRate.delegate = self
    }
    
    func getDataTop(){
        URLSession.shared.getRequest(url: APIlinks.topRateLink, decoding: request.self ){ [weak self] result in
            
            switch result{
                
            case .success(let movies):
                    
                self?.top = movies
                
                DispatchQueue.main.async {
                    self?.tableViewTopRate.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
                    
        }
    }
    
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let item = top?.results.count{
            return item
        }else{
            return 0
        }
        
    
        //  return top?.result?.count?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellTop = tableView.dequeueReusableCell(withIdentifier: "cellTop", for: indexPath)
        
        cellTop.textLabel?.text = top?.results[indexPath.row].title
        cellTop.detailTextLabel?.text = "Vote Average: \(String(top?.results[indexPath.row].voteAverage ?? 0))"
        
        return cellTop
    }
    
    
    
}
