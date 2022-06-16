//
//  ViewControllerNowPlaying.swift
//  APIMovies
//
//  Created by Consultant on 6/16/22.
//

import UIKit

class ViewControllerNowPlaying: UIViewController {

    @IBOutlet weak var tableViewPlaying: UITableView!
    
    var nowP : requestPlaying?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegatesPlaying()
        fetchPlaying()
    }
    
    func setupDelegatesPlaying(){
        tableViewPlaying.delegate = self
        tableViewPlaying.dataSource = self
    }
    
    func fetchPlaying(){
        
        URLSession.shared.getRequest(url: APIlinks.nowPlayingLink, decoding: requestPlaying.self){ [weak self] result in
            
            switch result {
                
                case .success(let now):
                    
                    self?.nowP = now
                    
                    DispatchQueue.main.async {
                        self?.tableViewPlaying.reloadData()
                    }
                
                case .failure(let error):
                    print(error)
            }
        }
        
    }
    
}


extension ViewControllerNowPlaying: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let item = nowP?.results.count {
            return item
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellNow = tableView.dequeueReusableCell(withIdentifier: "cellPlaying", for: indexPath)
        cellNow.textLabel?.text = nowP?.results[indexPath.row].title
        cellNow.detailTextLabel?.text = "Popularity: \(String(nowP?.results[indexPath.row].popularity ?? 0))"
        return cellNow
    }
    
}

