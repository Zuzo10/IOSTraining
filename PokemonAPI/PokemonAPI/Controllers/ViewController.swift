//
//  ViewController.swift
//  PokemonAPI
//
//  Created by Consultant on 6/17/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableViewPokemon: UITableView!
    
    var listPokemon : [mainPokemon]=[]
    var num : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
    
    }
    
    func setupDelegates(){
        tableViewPokemon.dataSource = self
        tableViewPokemon.delegate = self
        allPokemon()
    }
    
    func allPokemon(){
        for i in num...(num + 29){
            let pokemon = mainPokemon(id: (i + 1))
            listPokemon.append(contentsOf: [pokemon])
    
        }
        num = listPokemon.count
        self.tableViewPokemon.reloadData()
    }
    
    /*func getData(){
        
        URLSession.shared.requestData(url: linksPokemon.initialListPokemon, decoding: mainPokemon.self){ [weak self] data in
            
            switch data{
                
            case .success(let list):
                //print(list.results[].url)
                self?.listResult = list
                
                
            case .failure(let error):
                print(error)
            }
            
        }
    }*/

}


extension ViewController : UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPokemon.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        listPokemon[indexPath.row] = setPokemon(item: listPokemon[indexPath.row],cell: cell)
        
        //print(listPokemon[indexPath.row].types[0].type)
      
        //cell.textLabel?.text = listPokemon[indexPath.row].forms[0].name
       // cell.detailTextLabel?.text = listPokemon[indexPath.row].types[0].type.name
        
      return cell
        
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let vcDetails = storyboard?.instantiateViewController(identifier: "details") as! ViewControllerDetails
       // vcDetails.details = dataApi[indexPath.row]
       // self.navigationController?.show(vcDetails, sender: nil)
        
        let view =  storyboard?.instantiateViewController(identifier: "viewControllerDetails") as! ViewControllerDetails
        view.detail = listPokemon[indexPath.row]
        self.navigationController?.show(view, sender: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if listPokemon.count <= 150{
            if tableViewPokemon.contentOffset.y >= (tableViewPokemon.contentSize.height - tableViewPokemon.frame.size.height){
                //you reached end of the table
                allPokemon()
                tableViewPokemon.reloadData()
            }
        }
    }
   
    func setPokemon(item: mainPokemon,cell:UITableViewCell) -> mainPokemon! {
        var list : mainPokemon!
        list = item
      //  lblName.text = "pokemon \(pokemon!.id)"
       // imgView.downloaded(from: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemon.id).png")
        
        
        if list.forms.count == 0
        {
            print(list.id)
            seekId(id: list.id){ result in
                
                switch result {
                case .success(let p):
                    list = p
                    DispatchQueue.main.async {
                        
                        cell.textLabel?.text = list.forms[0].name
                        cell.detailTextLabel?.text = list.types[0].type.name
                        let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(list.id).png")
                        cell.imageView?.getImage(from: url!)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        return list
    }
    
    func seekId(id: Int, completion: @escaping (Result<mainPokemon,Error>)->()){
        URLSession.shared.requestData(url: URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/"), decoding: mainPokemon.self, completion: completion)
    }
    
}
