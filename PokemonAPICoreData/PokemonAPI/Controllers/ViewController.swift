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
    //var fav : [EntityPokemon]?
   
    var getData = crud()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allPokemon()
    }
    
    func setupDelegates(){
        tableViewPokemon.dataSource = self
        tableViewPokemon.delegate = self
       // allPokemon()
    }
    
    func allPokemon(){
        for i in num...(num + 29){
            let pokemon = mainPokemon(id: (i + 1))
            listPokemon.append(contentsOf: [pokemon])
    
        }
        num = listPokemon.count
        
        self.tableViewPokemon.reloadData()
    }


}


extension ViewController : UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPokemon.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        listPokemon[indexPath.row] = setPokemon(item: listPokemon[indexPath.row],cell: cell)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        if  getData.seek(idData: indexPath.row){
            
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
        
            self.getData.addNew(pokeId: Int16(buttonTag))
        
        }else{
          
            self.getData.deleteData(pokeId: Int16(buttonTag))
            sender.setImage(UIImage(systemName: "star"), for: .normal)
                                    
        
        }
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        
        let view =  storyboard?.instantiateViewController(identifier: "viewControllerDetails") as! ViewControllerDetails
        view.detail = listPokemon[indexPath.row].id
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
