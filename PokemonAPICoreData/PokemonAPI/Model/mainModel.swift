//
//  Model.swift
//  PokemonAPI
//
//  Created by Consultant on 6/17/22.
//

import Foundation
import CoreData


public class dataFavorites: NSManagedObject {
    @NSManaged var id: Int16
    @NSManaged var namePoke: String
    @NSManaged var typePoke: String
    
}


class mainPokemon: Codable {
    
    //codeable properties
    var id: Int
    var forms: [Forms]
    var types: [Types]
    
    init(id:Int){
        self.id = id
        forms = [Forms]()
        types = [Types]()
    }
}
struct Types: Codable{
//    var slot:Int
    var type: Forms
}
struct Forms: Codable{
    var name: String
    var url: String
}
/*
struct mainPokemon : Codable{
    var next : String
    var previous : String!
    var results : [subPokemon]
}

struct subPokemon : Codable {
    var url : String   //url with all data
}


struct detailPokemon: Codable {
   
    var forms: [datosP]
    var sprites: Sprites
    var types: [TypeElement]
    
}


struct datosP: Codable {
    var name: String //name nombre
}

struct Sprites : Codable {  //picture
    
    var backDefault: String
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        
    }

}

struct TypeElement: Codable { //type
    var type: datosP
}




struct detailsPokemon :Codable{
    var sprites : [detailsSprites]
    var types : [detailsTypes]
}

struct detailsSprites : Codable{
    
    var backShiny :String
    
    enum CodingKeys : String,CodingKey{
        case backShiny = "back_shiny"
    }
}

struct detailsTypes : Codable {
    
    var detTypes : [detType]
    
}

struct detType : Codable {
    
    var type : String
}
*/
