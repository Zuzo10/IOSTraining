//
//  crudCD.swift
//  PokemonAPI
//
//  Created by Consultant on 6/24/22.
//

import UIKit
import CoreData



public class crud {
    
    private let viewContext : NSManagedObjectContext!
    
    static let shared = crud()
    
    init(){
       viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func fetchData<T:NSManagedObject>(_type:T.Type)->[T]{
        
        do{
           // let result = try viewContext.fetch(Pais.fetchRequest())
            let result = try viewContext.fetch(T.fetchRequest())
            return result as! [T]
        }catch{
            return []
        }
        
    }
    
    func addNew(pokeId:Int16){
        print("new: \(pokeId)")
        
        let newCountry = EntityPokemon(context: self.viewContext)
        newCountry.id = pokeId
        save()
    }
    

    func deleteData(pokeId:Int16) {
        
        print("delet: \(pokeId)")
        let request : NSFetchRequest<EntityPokemon> = EntityPokemon.fetchRequest()
        request.predicate = NSPredicate(format: "id == %id", pokeId)

        do {
           if let result = try viewContext.fetch(request).first {
              
               viewContext.delete(result)
               save()
           }
        } catch {
           print(error)
        }
        
         
        
        
    }
    
    func save(){
        do {
            try viewContext.save()
          
        } catch {
            print(error.localizedDescription)
      
        }
    }
    
    func seek(idData:Int) -> Bool{
    
        let request : NSFetchRequest<EntityPokemon> = EntityPokemon.fetchRequest()
        request.predicate = NSPredicate(format: "id == %id", idData)

        do {
           if let result = try viewContext.fetch(request).first {
              // let userName = result.proname
             //  let price = result.price
             //  print("User Name is : \(userName) and price is : \(price)")
               print(result)
               return true
           } else {
               return false
           }
        } catch {
           print(error)
        }
        return false
    }
}

