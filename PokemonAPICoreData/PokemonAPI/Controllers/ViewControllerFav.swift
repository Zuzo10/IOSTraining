//
//  ViewControllerFav.swift
//  PokemonAPI
//
//  Created by Consultant on 6/24/22.
//

import UIKit

class ViewControllerFav: UIViewController {

    @IBOutlet weak var tableViewFav: UITableView!
    
    var listFav : [EntityPokemon] = []
    var numFav : Int = 0
    var getData = crud()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDelegates()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favPokemon()
    }
    
    func setupDelegates(){
        
        tableViewFav.delegate = self
        tableViewFav.dataSource = self
        favPokemon()
    }
    
    func favPokemon(){
        
        listFav = getData.fetchData(_type: EntityPokemon.self)
        self.tableViewFav.reloadData()
    }
    

}

extension ViewControllerFav : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFav.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFav",for: indexPath)
        setPokemon(item: listFav[indexPath.row].id,cell: cell)
        //cell.textLabel?.text =  String(listFav[indexPath.row].id)
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let view =  storyboard?.instantiateViewController(identifier: "viewControllerDetails") as! ViewControllerDetails
        let numPoke = Int(listFav[indexPath.row].id) + 1
        view.detail = numPoke//listPokemon[indexPath.row]
        self.navigationController?.show(view, sender: nil)
        
    
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if listFav.count <= 150{
            if tableViewFav.contentOffset.y >= (tableViewFav.contentSize.height - tableViewFav.frame.size.height){
               favPokemon()
                //tableViewFav.reloadData()
            }
        }
    }
   
    
    
    func setPokemon(item: Int16,cell:UITableViewCell) {
        var list : mainPokemon!
      
        let idPokemon = item + 1
        
            print("id by cell \(idPokemon)")
            seekId(id: Int(idPokemon)){ result in
                
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
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete"){ (action,view,completionHandler) in
            
            let deletePokemon = self.listFav[indexPath.row].id
            print(deletePokemon)
            self.getData.deleteData(pokeId: Int16(deletePokemon))
            self.favPokemon()
            
        }
        
        return UISwipeActionsConfiguration(actions: [actionDelete])
    }
    
    func seekId(id: Int, completion: @escaping (Result<mainPokemon,Error>)->()){
        URLSession.shared.requestData(url: URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/"), decoding: mainPokemon.self, completion: completion)
    }
    
    
}
