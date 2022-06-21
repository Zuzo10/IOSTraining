//
//  ViewController.swift
//  CodableDota
//
//  Created by Admin on 6/15/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var heroes = [Hero]()
    var fav = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
       
    }
    
    func setupTableView() {
        // here we are calling our func not with () but {} because of the @escaping closure we update the tableview data here
        fetchJson {
            self.tableview.reloadData()
            self.fav = UserDefaults.standard.array(forKey: "favorites") as! [Int]
            print(self.fav )
            
           
        }
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    /*
     A closure is said to escape a function when the closure is passed as an aurgument to the function, but is called after the function returns. Escaping closures outlive the function it was passed into
     https://www.appypie.com/escaping-closures-swift
     https://betterprogramming.pub/escaping-and-non-escaping-closures-in-swift-fe2866309599
     */
    
    func fetchJson(completed: @escaping ()-> ()) {
        guard let url = URL(string: "https://api.opendota.com/api/heroStats") else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("Error: \(error?.localizedDescription ?? "Something stange happened")")
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("server error!")
                return
            }
            
            guard data != nil else {
                print("Error: We have no data bub")
                return
            }
            
            do {
                // instad of needing to first serialize the json with JSONSeerialization class or associated functions we can instead let the instance of our array of heroes hold the decoded data directly. As of Swift 4.0 no more manual serialization
                self.heroes = try JSONDecoder().decode([Hero].self, from: data!)
                
                DispatchQueue.main.async {
                    // here we call the closure to indicate this is where the results of the fetch should be called
                    completed()
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            
        }
        task.resume()
    }

}

extension ViewController:UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = heroes[indexPath.row].name.capitalized
    
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        if fav.contains(indexPath.row){
            button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }else{
            button.setImage(UIImage(systemName: "star"), for: .normal)
        }
        

        button.addTarget(self, action: #selector(changeStar(sender:)), for: .touchUpInside)
        button.tag = indexPath.row
        cell.accessoryView = button
        
        return cell
    }
    
    @objc func changeStar(sender: UIButton ){
        let buttonTag = sender.tag
        
        if sender.currentImage!.isEqual(UIImage(systemName: "star")) {
            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
            
            UserDefaults.standard.favorites.append(buttonTag)
        
        }else{
            sender.setImage(UIImage(systemName: "star"), for: .normal)
            
            if let num = UserDefaults.standard.favorites.firstIndex(of: buttonTag){
                UserDefaults.standard.favorites.remove(at: num)
            }
            
            
           // let index = fav.firstIndex(of: buttonTag)
          //  fav.remove(at: index!)
          //  UserDefaults.standard.favorites = fav
        }
        
    }
    
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.hero = heroes[(tableview.indexPathForSelectedRow?.row)!]
        }
    }
}
